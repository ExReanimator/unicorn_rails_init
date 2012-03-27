work_dir = "/path/to/app/root/"

socket_path = "#{work_dir}tmp/sockets/unicorn.sock"
pid_path = "#{work_dir}tmp/pids/unicorn.pid"
err_log = "#{work_dir}log/unicorn.stderr.log"
out_log = "#{work_dir}log/unicorn.stdout.log"

worker_processes 4
working_directory work_dir

preload_app true

timeout 30

listen socket_path, :backlog => 1024

pid pid_path

stderr_path err_log
stdout_path out_log

before_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
end
