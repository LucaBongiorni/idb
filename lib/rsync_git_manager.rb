require 'git'

class RsyncGitManager
  def initialize remote_path, local_path
    @remote_path = remote_path
    @local_path = local_path
    FileUtils.mkdir_p @local_path unless Dir.exist? @local_path
    begin
      @g = Git.open(local_path, :log => $log)
    rescue
      Git.init(local_path)
      @g = Git.open(local_path, :log => $log)
    end
  end

  def sync_new_revision
    $log.info "Hard resetting work dir #{@local_path}..."
    @g.reset_hard
    cmd = "rsync -avz -e 'ssh -oStrictHostKeyChecking=no  -p #{$device.tool_port}'  root@localhost:#{Shellwords.escape(@remote_path)}/ #{Shellwords.escape(@local_path)}/"
    $log.info "Executing rsync command #{cmd}"
    `#{cmd}`
    @g.add(:all=>true)
    begin
      @g.commit_all("Snapshot from #{Time.now.to_s}")
    rescue
    end


  end



end