class Chef
  module Mixin
    module Nodebrew
      def load_current_resource
        super
        @nodebrew_root
      end

      def nodebrew_missing?
        !which('nodebrew')
      end

      def node_installed?(version)
        ::File.directory? ::File.join(nodebrew_root, 'src', version)
      end

      def nodebrew_root
        return @nodebrew_root if @nodebrew_root
        path = which('nodebrew')
        return unless path
        @nodebrew_root = path.gsub(%r(/current/bin/nodebrew), '')
      end

      def which(cmd)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(::File::PATH_SEPARATOR).each do |path|
          exts.each do |ext|
            exe = "#{path}/#{cmd}#{ext}"
            return exe if ::File.executable? exe
          end
        end
        nil
      end
    end
  end
end
