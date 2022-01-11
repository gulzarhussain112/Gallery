module ApplicationHelper

    def flash_class_name(name)
        case name
        when "notice" then "success"
        when "alert"  then "danger"
        else name
        end
      end

      def active_class?(link_path)
        'active' if current_page?(link_path)
    end
end
