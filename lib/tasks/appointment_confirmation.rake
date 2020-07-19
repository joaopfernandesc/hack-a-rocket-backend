namespace :appointment_confirmation do
    task :send_messages => :environment do
        current_timestamp = Time.current.to_i
        Appointment.where(is_canceled: false, warning_pending: true).where("send_timestamp <= ?", current_timestamp).each(&:send_scheduled_messages)
    end
end