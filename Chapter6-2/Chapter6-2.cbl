       Identification Division.
           Program-ID. Chapter6-2.
               Author. Anthony Downs.
               Installation.
               Date-Written. March 21, 2016.
               Date-Compiled.
               Security.
               
       Environment Division.
           Configuration Section.
               Special-Names.
               
           Input-Output Section.
               File-Control.
                   Select PayrollReport assign to PayRpt
                       File Status is File_Status
                       Organization is Line Sequential.
               
               I-O-Control.
               
       Data Division.
           File Section.
               FD  PayrollReport
                   Record Contains 132 characters.
                   01  EmployeeRecord                      PIC X(132).
                   
           Working-Storage Section.
               COPY "Misc.cpy".
               COPY "WS_Date.cpy".
               Copy "ScreenColors.cpy".
               
               01  EmployeeRecords.
                   05  EmployeeNumber                      PIC X(5).
                   05                                      PIC X(5) value spaces.
                   05  EmployeeName                        PIC X(20).
                   05                                      PIC X(5) value spaces.
                   05  TerritoryNumber                     PIC X(2).
                   05                                      PIC X(2) value spaces.
                   05  OfficeNumber                        PIC X(2).
                   05                                      PIC X(5) value spaces.
                   05  AnnualSalary                        PIC 9(1),9(3).9(2).
                   05                                      PIC X(5) values spaces.
                   05  SocialSecurityNumber                PIC 9(9).
                   05  SSNumber redefines SocialSecurityNumber.
                       10  FirstDigits                     PIC X(3).
                       10  SecondDigits                    PIC X(2).
                       10  ThirdDigits                     PIC X(4).
                           
                   
           Screen Section.
               01  HeaderScreen.
                   05  Blank Screen
                       Foreground-color Blue
                       Background-color Cyan.
                   05  Line 4 Column 25                        value "Welcome To The Agile Payroll Menu".
               01  MainScreen.
                   05  Input-Prompt.
                       10  Line 8 Column 10                    value "Please Enter The Employee Number: ".
                       10  Line 9 Column 10                    value "Enter The Employee Name: ".
                       10  Line 10 Column 10                   value "Territory Number: ".
                       10  Line 11 Column 10                   value "Office Number: ".
                       10  Line 12 Column 10                   value "Annual Salary: ".
                       10  Line 13 Column 10                   value "Social Security Number: ".
                   05  Input-Answers
                       Auto.
                       10  Line 8 Column 45                PIC X(5) TO EmployeeNumber.
                       10  Line 9 Column 45                PIC X(20) TO EmployeeName.
                       10  Line 10 Column 45               PIC X(2) TO TerritoryNumber.
                       10  Line 11 Column 45               PIC X(2) TO OFficeNumber.
                       10  Line 12 Column 45               PIC X(6) TO AnnualSalary.
                       10  Line 13 Column 45               PIC X(9) TO SocialSecurityNumber.
                          
           
       Procedure Division.
           Initilization.
               INITIALIZE EmployeeRecord
               PERFORM 100-Open-Files
               DISPLAY HeaderScreen
               DISPLAY MainScreen
               ACCEPT MainScreen
               MOVE SocialSecurityNumber TO SSNumber.
               MOVE ThirdDigits in SSNumber TO AnnualSalary.
               MOVE SocialSecurityNumber(4:2) TO AnnualSalary.
               PERFORM 400-Write-Records.
               PERFORM 500-Close-Files.
               STOP RUN.
         
 
           100-Open-Files.
               OPEN OUTPUT PayrollReport
                   CALL "Validations" USING File_Status.
                   
           
           200-Read-Records.
           
           300-Write-Heading.
           
           400-Write-Records.
               WRITE EmployeeRecord FROM EmployeeRecords.
           
           500-Close-Files.
               CLOSE PayrollReport.
               
           600-FormatDate.
           
           700-FormatTime.
           
           800-Validations.
           
       End Program.