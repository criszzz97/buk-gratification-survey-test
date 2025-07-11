module GratificationImplementations
    # Este constructor permite modificar en la instancia de la implementacion datos relativamente estaticos, como los dias del año tomados en cuenta para el calculo de gratificaciones.
    class ColombiaGratification < GeneralGratification
        def initialize(daysCountedInYear:360)
            if daysCountedInYear > 365
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be greater than 365"
            end

            if daysCountedInYear <= 0
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be equal or lower to 0"
            end

            @daysCountedInYear = daysCountedInYear
        end

        # Esta funcion recibe como input los datos ingresados por el usuario (Salario mensual y Dias trabajados en el semetre) y retorna un texto que contiene el desglose del caculo de gratificacion.
        def getDetails(input)
            self.validateInput(input)
            monthlySalary = (input[:monthly_salary]).to_f
            monthlySalaryStr =(monthlySalary.to_i).to_s
            workedDaysSemester = (input[:worked_days_semester]).to_i
            ammountGratification = self.getGratification(monthlySalary,workedDaysSemester)
            ammountGratificationStr = (ammountGratification.to_i).to_s
            return "Desglose: ($#{monthlySalaryStr}x#{workedDaysSemester})/#{@daysCountedInYear} = $#{ammountGratificationStr}"
        end

        # Esta funcion calcula la gratificacion a partir del salario mensual y los dias trabajados en el semestre.
        def getGratification(monthlySalary,workedDaysSemester)
            return ((monthlySalary*workedDaysSemester)/@daysCountedInYear).to_i
        end    

        # Esta funcion recibe como input los datos ingresados por el usuario (Salario mensual y Dias trabajados en el semetre) y retorna el monto de gratificacion cálculado a partir de los datos de entrada.
        def getAmount(input)
            self.validateInput(input)
            monthlySalary = (input[:monthly_salary]).to_f
            workedDaysSemester = (input[:worked_days_semester]).to_i
            return self.getGratification(monthlySalary,workedDaysSemester)
        end
        
        # Esta funcion valida los datos ingresados por el usuario (Salario mensual y Dias trabajados en el semetre) con una clase DTO especifico asociado a esta implementacion.
        def validateInput(input)
            inputDto = ::InputModels::ColombiaGratificationInput.new(monthly_salary:input[:monthly_salary],worked_days_semester:input[:worked_days_semester])
            inputDto.validate!
        end  
    end
end
