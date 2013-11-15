module ApplicationHelper
  
  def flash_class(level)
      case level
          when :notice then "alert alert-info"
          when :success then "alert alert-success"
          when :error then "alert alert-error"
          when :alert then "alert alert-error"
      end
  end
  
  def check_browser
    if !browser.chrome?
      flash.now[:alert] = ["Ensong's usability is only guaranteed on Chrome.  If you encounter problems, please switch to that browser."]
    end
  end
  
end
