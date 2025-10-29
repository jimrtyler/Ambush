


function New-PayrollDecoy {
    <#
    .SYNOPSIS
    Creates a realistic Payroll server folder structure with decoy files.
    
    .DESCRIPTION
    Creates a comprehensive Payroll department folder structure with realistic
    subfolders and sample files for security testing and honeypot purposes.
    
    .PARAMETER Path
    The directory where the Payroll structure will be created.
    
    .EXAMPLE
    New-PayrollDecoy -Path "C:\Shares"
    Creates Payroll structure at C:\Shares\Payroll
    #>
    
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    Write-Host "`nCreating Payroll decoy structure in: $Path" -ForegroundColor Cyan
    
    # Create main Payroll folder
    $PayrollRoot = Join-Path -Path $Path -ChildPath "Payroll"
    if (-not (Test-Path -Path $PayrollRoot)) {
        New-Item -Path $PayrollRoot -ItemType Directory -Force | Out-Null
        Write-Host "  Created: Payroll\" -ForegroundColor Green
    }
    
    # Payroll subfolder structure
    $PayrollFolders = @{
        "Employee_Records" = @(
            "Active",
            "Terminated",
            "On_Leave",
            "Contractors",
            "Background_Checks",
            "Performance_Reviews",
            "Personal_Info",
            "Emergency_Contacts",
            "I-9_Forms"
        )
        "Tax_Documents" = @(
            "W2_Forms",
            "1099_Forms",
            "State_Tax",
            "Federal_Tax",
            "Estimated_Tax",
            "Tax_Audits",
            "Local_Tax",
            "Tax_Exemptions",
            "Withholding_Forms"
        )
        "Timesheets" = @(
            "2024",
            "2025",
            "Archive",
            "Drafts",
            "Approved",
            "Overtime_Reports",
            "Payroll_Periods",
            "Timesheet_Templates"
        )
        "Benefits" = @(
            "Health_Insurance",
            "401k",
            "PTO_Tracking",
            "Enrollment_Forms",
            "Dental",
            "Vision",
            "Life_Insurance",
            "Benefit_Statements",
            "COBRA"
        )
        "Direct_Deposit" = @(
            "Bank_Information",
            "Change_Requests",
            "Verification_Forms",
            "Routing_Confirmations",
            "Deposit_History",
            "ACH_Forms",
            "Bank_Contacts",
            "Failed_Transactions"
        )
        "Payroll_Reports" = @(
            "Monthly",
            "Quarterly",
            "Annual",
            "Audit_Reports",
            "Year_To_Date",
            "Budget_Reports",
            "Tax_Summaries",
            "Executive_Summaries",
            "Variance_Analysis"
        )
        "Salary_Information" = @(
            "Compensation_Plans",
            "Raise_Approvals",
            "Bonus_Records",
            "Job_Grades",
            "Pay_Scales",
            "Equity_Awards",
            "Salary_Surveys",
            "Commission_Structures"
        )
        "Deductions" = @(
            "Garnishments",
            "Child_Support",
            "Tax_Withholdings",
            "Benefits_Deductions",
            "Voluntary_Deductions",
            "Retirement_Contributions",
            "Loan_Repayments",
            "Pretax_Deductions"
        )

        # Added 5 more root folders with subfolders
        "Vendor_Payments" = @(
            "Approved_Invoices",
            "Pending_Invoices",
            "Payment_Run_Logs",
            "Payment_Methods",
            "Vendor_W9s",
            "Vendor_Contracts",
            "Reconciliation",
            "Failed_Payments"
        )
        "Expense_Reimbursements" = @(
            "Submitted_Requests",
            "Approved_Reimbursements",
            "Receipts",
            "Policy_Guidelines",
            "Card_Statements",
            "Mileage_Logs",
            "Expense_Audits",
            "Reimbursement_Templates"
        )
        "Compliance" = @(
            "SOX_Documents",
            "PCI_Controls",
            "GDPR_Requests",
            "Audit_Findings",
            "Control_Testing",
            "Policy_Updates",
            "Training_Records",
            "Remediation_Plans"
        )
        "Onboarding_and_Offboarding" = @(
            "New_Hire_Checklists",
            "Offer_Letters",
            "Onboarding_Forms",
            "Exit_Checklists",
            "Final_Payments",
            "Equipment_Returns",
            "Access_Revocations",
            "Orientation_Materials"
        )
        "Archives" = @(
            "2018_Archived",
            "2019_Archived",
            "2020_Archived",
            "2021_Archived",
            "2022_Archived",
            "Retention_Logs",
            "Destruction_Requests",
            "Archive_Index"
        )
    }
    
    # Create subfolder structure
    foreach ($MainFolder in $PayrollFolders.Keys) {
        $MainFolderPath = Join-Path -Path $PayrollRoot -ChildPath $MainFolder
        New-Item -Path $MainFolderPath -ItemType Directory -Force | Out-Null
        Write-Host "  Created: Payroll\$MainFolder\" -ForegroundColor Green
        
        foreach ($SubFolder in $PayrollFolders[$MainFolder]) {
            $SubFolderPath = Join-Path -Path $MainFolderPath -ChildPath $SubFolder
            New-Item -Path $SubFolderPath -ItemType Directory -Force | Out-Null
            Write-Host "    Created: Payroll\$MainFolder\$SubFolder\" -ForegroundColor DarkGreen
        }
    }
    
    # Create sample decoy files
    Write-Host "`n  Creating decoy files..." -ForegroundColor Yellow
    
    # Employee Records - Sample employee list
    $EmployeeListPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Employee_Records\Active") -ChildPath "Employee_Roster_2025.xlsx"
    "Employee ID,Name,Department,Hire Date,Status`n" + `
    "E001,John Smith,Engineering,2020-03-15,Active`n" + `
    "E002,Sarah Johnson,HR,2019-07-22,Active`n" + `
    "E003,Michael Chen,Finance,2021-01-10,Active" | Out-File -FilePath $EmployeeListPath -Encoding UTF8
    Write-Host "    Created: Employee_Roster_2025.xlsx" -ForegroundColor Cyan
    
    # Tax Documents - Sample W2
    $W2Path = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Tax_Documents\W2_Forms") -ChildPath "W2_2024_Template.txt"
    @"
W-2 Wage and Tax Statement - 2024
=====================================
Company: Acme Corporation
EIN: XX-XXXXXXX

This folder contains W-2 forms for all employees.
DO NOT DISTRIBUTE without HR approval.
Contact: payroll@acmecorp.com
"@ | Out-File -FilePath $W2Path -Encoding UTF8
    Write-Host "    Created: W2_2024_Template.txt" -ForegroundColor Cyan
    
    # Timesheets - Sample timesheet
    $TimesheetPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Timesheets\2025") -ChildPath "January_2025_Timesheets.csv"
    "Employee ID,Name,Week Ending,Hours Worked,Overtime Hours`n" + `
    "E001,John Smith,2025-01-05,40,0`n" + `
    "E002,Sarah Johnson,2025-01-05,38,0`n" + `
    "E003,Michael Chen,2025-01-05,42,2" | Out-File -FilePath $TimesheetPath -Encoding UTF8
    Write-Host "    Created: January_2025_Timesheets.csv" -ForegroundColor Cyan
    
    # Direct Deposit - Sample banking info template
    $DirectDepositPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Direct_Deposit\Bank_Information") -ChildPath "Direct_Deposit_Form_TEMPLATE.txt"
    @"
DIRECT DEPOSIT AUTHORIZATION FORM
=====================================

Employee Name: _______________________
Employee ID: _________________________
Bank Name: ___________________________
Routing Number: ______________________
Account Number: ______________________

CONFIDENTIAL - HR USE ONLY
Date Processed: ______________
Processed By: ________________
"@ | Out-File -FilePath $DirectDepositPath -Encoding UTF8
    Write-Host "    Created: Direct_Deposit_Form_TEMPLATE.txt" -ForegroundColor Cyan
    
    # Payroll Reports - Sample monthly report
    $PayrollReportPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Payroll_Reports\Monthly") -ChildPath "December_2024_Summary.txt"
    @"
PAYROLL SUMMARY REPORT
Month: December 2024
Generated: $(Get-Date -Format 'yyyy-MM-dd')
=====================================

Total Employees: 145
Total Gross Wages: `$847,523.00
Total Tax Withholdings: `$203,405.52
Total Net Pay: `$644,117.48

Department Breakdown:
- Engineering: 45 employees, `$312,450.00
- Sales: 38 employees, `$245,890.00
- Operations: 32 employees, `$178,234.00
- Administration: 30 employees, `$110,949.00

CONFIDENTIAL - Finance Department Only
"@ | Out-File -FilePath $PayrollReportPath -Encoding UTF8
    Write-Host "    Created: December_2024_Summary.txt" -ForegroundColor Cyan
    
    # Salary Information - Compensation plan
    $SalaryInfoPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Salary_Information\Compensation_Plans") -ChildPath "2025_Salary_Ranges.txt"
    @"
2025 SALARY RANGES BY POSITION
=====================================
STRICTLY CONFIDENTIAL - HR ONLY

Engineering Department:
- Junior Developer: `$65,000 - `$85,000
- Mid-Level Developer: `$90,000 - `$120,000
- Senior Developer: `$125,000 - `$160,000
- Engineering Manager: `$140,000 - `$180,000

Sales Department:
- Sales Associate: `$45,000 - `$60,000 + Commission
- Account Manager: `$70,000 - `$95,000 + Commission
- Sales Director: `$110,000 - `$150,000 + Commission

Last Updated: January 2025
HR Contact: hr.compensation@acmecorp.com
"@ | Out-File -FilePath $SalaryInfoPath -Encoding UTF8
    Write-Host "    Created: 2025_Salary_Ranges.txt" -ForegroundColor Cyan
    
    # Benefits - 401k information
    $BenefitsPath = Join-Path -Path (Join-Path -Path $PayrollRoot -ChildPath "Benefits\401k") -ChildPath "401k_Contributions_Q4_2024.csv"
    "Employee ID,Name,Employee Contribution,Employer Match,Total`n" + `
    "E001,John Smith,500.00,250.00,750.00`n" + `
    "E002,Sarah Johnson,750.00,375.00,1125.00`n" + `
    "E003,Michael Chen,600.00,300.00,900.00" | Out-File -FilePath $BenefitsPath -Encoding UTF8
    Write-Host "    Created: 401k_Contributions_Q4_2024.csv" -ForegroundColor Cyan
    
    # Create a README file
    $ReadmePath = Join-Path -Path $PayrollRoot -ChildPath "README.txt"
    @"
PAYROLL DEPARTMENT - CONFIDENTIAL
=====================================

This folder contains sensitive payroll and employee compensation information.

Access is restricted to:
- Payroll Department Staff
- HR Management
- Finance Department (Reports only)

Security Classification: HIGHLY CONFIDENTIAL

For questions or access requests:
Email: payroll@acmecorp.com
Phone: (555) 123-4567

Last Updated: $(Get-Date -Format 'MMMM dd, yyyy')

WARNING: Unauthorized access, disclosure, or distribution of this 
information may result in disciplinary action up to and including 
termination, and may be subject to civil and criminal penalties.
"@ | Out-File -FilePath $ReadmePath -Encoding UTF8
    Write-Host "    Created: README.txt" -ForegroundColor Cyan
    
    Write-Host "`nPayroll decoy structure created successfully!" -ForegroundColor Green
    Write-Host "Location: $PayrollRoot" -ForegroundColor White
}

# Function to create random API key JSON file
    function Create-APIKeyFile {
        param(
            [string]$DocumentsPath,
            [string]$Username
        )
        
        $APIServices = @(
            @{ 
                Service = "OpenAI"; Type = "openai"; 
                Patterns = @("openai_api_key.json", "chatgpt_key.json", "openai_secret.json", "ai_api_credentials.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "organization" = "org-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Stripe"; Type = "stripe"; 
                Patterns = @("stripe_api_key.json", "stripe_secret.json", "payment_keys.json", "stripe_credentials.json")
                JSONTemplate = @{
                    "secret_key" = ""
                    "publishable_key" = "pk_live_" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "webhook_secret" = "whsec_" + (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "PayPal"; Type = "paypal"; 
                Patterns = @("paypal_api_key.json", "paypal_credentials.json", "paypal_secret.json", "payment_api.json")
                JSONTemplate = @{
                    "client_id" = ""
                    "client_secret" = (-join ((1..64) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "mode" = "live"
                }
            },
            @{ 
                Service = "AWS"; Type = "aws"; 
                Patterns = @("aws_api_key.json", "amazon_credentials.json", "aws_secret.json", "cloud_keys.json")
                JSONTemplate = @{
                    "AccessKeyId" = ""
                    "SecretAccessKey" = (-join ((1..40) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(43, 47) | Get-Random) }))
                    "Region" = @("us-east-1", "us-west-2", "eu-west-1", "ap-southeast-1") | Get-Random
                }
            },
            @{ 
                Service = "Azure"; Type = "azure"; 
                Patterns = @("azure_api_key.json", "microsoft_credentials.json", "azure_secret.json", "azure_keys.json")
                JSONTemplate = @{
                    "subscription_id" = [guid]::NewGuid().ToString()
                    "client_id" = [guid]::NewGuid().ToString()
                    "client_secret" = ""
                    "tenant_id" = [guid]::NewGuid().ToString()
                }
            },
            @{ 
                Service = "GCP"; Type = "gcp"; 
                Patterns = @("gcp_api_key.json", "google_cloud_key.json", "gcp_credentials.json", "google_api.json")
                JSONTemplate = @{
                    "type" = "service_account"
                    "project_id" = "my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) }))
                    "private_key_id" = (-join ((1..40) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "private_key" = "-----BEGIN PRIVATE KEY-----`nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC..." + (-join ((1..50) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) + "`n-----END PRIVATE KEY-----"
                    "client_email" = "service-account@my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) })) + ".iam.gserviceaccount.com"
                    "client_id" = (-join ((1..21) | ForEach-Object { [char](48..57 | Get-Random) }))
                }
            },
            @{ 
                Service = "Square"; Type = "generic"; 
                Patterns = @("square_api_key.json", "square_credentials.json", "square_secret.json", "pos_api.json")
                JSONTemplate = @{
                    "application_id" = "sq0idp-" + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "access_token" = ""
                    "environment" = "production"
                    "location_id" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Claude"; Type = "generic"; 
                Patterns = @("claude_api_key.json", "anthropic_key.json", "claude_credentials.json", "anthropic_api.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "model" = "claude-3-sonnet-20240229"
                    "max_tokens" = 4096
                }
            },
            @{ 
                Service = "Verkada"; Type = "generic"; 
                Patterns = @("verkada_api_key.json", "verkada_credentials.json", "camera_api.json", "verkada_secret.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "org_id" = (-join ((1..8) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..12) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "base_url" = "https://api.verkada.com"
                }
            },
            @{ 
                Service = "YouTube"; Type = "generic"; 
                Patterns = @("youtube_api_key.json", "google_youtube_key.json", "youtube_credentials.json", "video_api.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "quota_user" = $Username
                    "part" = @("snippet", "statistics", "contentDetails")
                }
            },
            @{ 
                Service = "Twilio"; Type = "generic"; 
                Patterns = @("twilio_api_key.json", "sms_api_key.json", "twilio_credentials.json", "messaging_api.json")
                JSONTemplate = @{
                    "account_sid" = "AC" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "auth_token" = ""
                    "api_key" = "SK" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "api_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "SendGrid"; Type = "generic"; 
                Patterns = @("sendgrid_api_key.json", "email_api_key.json", "sendgrid_secret.json", "mail_credentials.json")
                JSONTemplate = @{
                    "api_key" = "SG." + (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) })) + "." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "from_email" = "noreply@" + (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".com"
                }
            },
            @{ 
                Service = "Shopify"; Type = "generic"; 
                Patterns = @("shopify_api_key.json", "store_credentials.json", "ecommerce_api.json", "shopify_secret.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "password" = ""
                    "shared_secret" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "shop_domain" = (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".myshopify.com"
                }
            },
            @{ 
                Service = "Discord"; Type = "generic"; 
                Patterns = @("discord_bot_token.json", "discord_api_key.json", "bot_credentials.json", "discord_secret.json")
                JSONTemplate = @{
                    "bot_token" = ""
                    "client_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
                    "client_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "guild_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
                }
            },
            @{ 
                Service = "Slack"; Type = "generic"; 
                Patterns = @("slack_api_key.json", "slack_bot_token.json", "workspace_credentials.json", "slack_webhook.json")
                JSONTemplate = @{
                    "bot_token" = "xoxb-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "app_token" = "xapp-1-" + (-join ((1..11) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..64) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                    "webhook_url" = "https://hooks.slack.com/services/T" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/B" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "GitHub"; Type = "generic"; 
                Patterns = @("github_token.json", "git_credentials.json", "repo_access_token.json", "github_api_key.json")
                JSONTemplate = @{
                    "token" = "ghp_" + (-join ((1..36) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "username" = $Username
                    "scope" = @("repo", "user", "admin:org")
                }
            },
            @{ 
                Service = "GitLab"; Type = "generic"; 
                Patterns = @("gitlab_token.json", "gitlab_api_key.json", "git_access_token.json", "gitlab_credentials.json")
                JSONTemplate = @{
                    "access_token" = "glpat-" + (-join ((1..20) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "username" = $Username
                    "gitlab_url" = "https://gitlab.com"
                }
            },
            @{ 
                Service = "Dropbox"; Type = "generic"; 
                Patterns = @("dropbox_api_key.json", "storage_credentials.json", "dropbox_token.json", "file_api_key.json")
                JSONTemplate = @{
                    "access_token" = "sl." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "app_key" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                    "app_secret" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Mailchimp"; Type = "generic"; 
                Patterns = @("mailchimp_api_key.json", "email_marketing_key.json", "mailchimp_secret.json", "campaign_api.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-us1"
                    "server" = "us1"
                    "username" = $Username
                }
            },
            @{ 
                Service = "Zoom"; Type = "generic"; 
                Patterns = @("zoom_api_key.json", "video_conf_key.json", "zoom_credentials.json", "meeting_api.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "api_secret" = ""
                    "jwt_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9." + (-join ((1..100) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            }
        )
        
        # Select random service and filename pattern
        $SelectedService = Get-Random -InputObject $APIServices
        $SelectedFilename = Get-Random -InputObject $SelectedService.Patterns
        
        # Generate API key based on service type
        $APIKey = Generate-RandomAPIKey -ServiceType $SelectedService.Type
        
        # Create JSON content based on service template
        $JSONData = $SelectedService.JSONTemplate.Clone()
        
        # Set the main API key field based on service
        switch ($SelectedService.Service) {
            "OpenAI" { $JSONData["api_key"] = $APIKey }
            "Stripe" { $JSONData["secret_key"] = $APIKey }
            "PayPal" { $JSONData["client_id"] = $APIKey }
            "AWS" { $JSONData["AccessKeyId"] = $APIKey }
            "Azure" { $JSONData["client_secret"] = $APIKey }
            "Square" { $JSONData["access_token"] = $APIKey }
            "Claude" { $JSONData["api_key"] = $APIKey }
            "Verkada" { $JSONData["api_key"] = $APIKey }
            "YouTube" { $JSONData["api_key"] = $APIKey }
            "Twilio" { $JSONData["auth_token"] = $APIKey }
            "Shopify" { $JSONData["password"] = $APIKey }
            "Discord" { $JSONData["bot_token"] = $APIKey }
            "Zoom" { $JSONData["api_secret"] = $APIKey }
            default { $JSONData["api_key"] = $APIKey }
        }
        
        # Convert to JSON with proper formatting
        $JSONContent = $JSONData | ConvertTo-Json -Depth 4
        
        # Save JSON file
        $FilePath = Join-Path -Path $DocumentsPath -ChildPath $SelectedFilename
        Set-Content -Path $FilePath -Value $JSONContent -Encoding UTF8
        
        Write-Host "  Created API key file: $SelectedFilename" -ForegroundColor Cyan
        
        # Return details for reporting
        return @{
            Service = $SelectedService.Service
            Filename = $SelectedFilename
            FilePath = $FilePath
        }
    }
    
    # Function to download random images for a user
    function Download-RandomImages {
        param(
            [string]$PicturesPath,
            [string]$Username
        )
        
        $ImageCount = Get-Random -Minimum 5 -Maximum 16
        $SelectedImages = Get-Random -InputObject $WikipediaImages -Count $ImageCount
        $DownloadedImages = @()
        
        Write-Host "  Downloading $ImageCount images for $Username..." -ForegroundColor Yellow
        
        foreach ($ImageData in $SelectedImages) {
            try {
                $ImageUrl = $ImageData.URL
                $FileName = $ImageData.Name
                $FilePath = Join-Path -Path $PicturesPath -ChildPath $FileName
                
                Invoke-WebRequest -Uri $ImageUrl -OutFile $FilePath -TimeoutSec 10 -ErrorAction SilentlyContinue
                
                $DownloadedImages += @{
                    Name = $FileName
                    Path = $FilePath
                }
            }
            catch {
                Write-Warning "Failed to download $($ImageData.Name) for $Username"
            }
        }
        
        # Return details for reporting
        return $DownloadedImages
    }
    
    function Set-Ambush {
    <#
    .SYNOPSIS
    Creates multiple randomly named user folders with standard Windows user profile subfolders.
    
    .DESCRIPTION
    This cmdlet creates user folders with realistic names and standard Windows user profile structure.
    Each folder includes Desktop, Documents, Downloads, AppData, and other typical user subfolders.
    
    .PARAMETER Path
    The root directory where user folders will be created. Defaults to C:\Users\
    
    .PARAMETER Count
    The number of user folders to create. Defaults to 100.
    
    .EXAMPLE
    Set-AmbushUsers
    Creates 100 user folders in C:\Users\
    
    .EXAMPLE
    Set-AmbushUsers -Path "D:\TestUsers" -Count 50
    Creates 50 user folders in D:\TestUsers
    #>
    
[CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Path = "C:\Users",
        
        [Parameter(Mandatory=$false)]
        [int]$Count = 100,
        
        [Parameter(Mandatory=$false)]
        [switch]$Report,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet("Payroll")]
        [string]$Decoy,

        [Parameter(Mandatory=$false)]
        [string]$Users
    )
    

    if($Users) {
    # Array of 2000 unique last names with diverse origins
    $LastNames = @(
        # Common American/English surnames
        "Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Wilson", "Anderson", "Thomas",
        "Taylor", "Moore", "Jackson", "Martin", "Lee", "Thompson", "White", "Harris", "Clark", "Lewis",
        "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Hill", "Green", "Adams",
        "Nelson", "Baker", "Hall", "Campbell", "Mitchell", "Carter", "Roberts", "Phillips", "Evans", "Turner",
        "Parker", "Edwards", "Collins", "Stewart", "Morris", "Murphy", "Cook", "Rogers", "Morgan", "Cooper",
        "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Kim", "Cox", "Ward", "Richardson", "Watson",
        "Brooks", "Wood", "James", "Bennett", "Gray", "Price", "Myers", "Long", "Ross", "Foster",
        "Powell", "Jenkins", "Perry", "Russell", "Sullivan", "Bell", "Coleman", "Butler", "Henderson", "Barnes",
        "Fisher", "Simmons", "Jordan", "Patterson", "Alexander", "Hamilton", "Graham", "Reynolds", "Griffin", "Wallace",
        "West", "Cole", "Hayes", "Bryant", "Gibson", "Ellis", "Stevens", "Murray", "Ford", "Marshall",
        "Owen", "Harrison", "McDonald", "Woods", "Washington", "Kennedy", "Wells", "Henry", "Freeman", "Webb",
        "Tucker", "Burns", "Crawford", "Olson", "Simpson", "Porter", "Hunter", "Gordon", "Shaw", "Snyder",
        "Mason", "Dixon", "Hunt", "Hicks", "Holmes", "Palmer", "Wagner", "Black", "Robertson", "Boyd",
        "Rose", "Stone", "Fox", "Warren", "Mills", "Meyer", "Rice", "Schmidt", "Daniels", "Ferguson",
        "Nichols", "Stephens", "Weaver", "Ryan", "Gardner", "Payne", "Grant", "Dunn", "Spencer", "Hawkins",
        "Arnold", "Pierce", "Hansen", "Peters", "Hart", "Bradley", "Knight", "Elliott", "Cunningham", "Duncan",
        "Armstrong", "Hudson", "Carroll", "Lane", "Riley", "Andrews", "Ray", "Berry", "Perkins", "Hoffman",
        "Johnston", "Matthews", "Richards", "Willis", "Carpenter", "Lawrence", "George", "Chapman", "Watkins",
        "Greene", "Wheeler", "Harper", "Burke", "Larson", "Morrison", "Franklin", "Carlson", "Austin", "Carr",
        "Lawson", "Jacobs", "O'Brien", "Lynch", "Bishop", "Montgomery", "Oliver", "Jensen", "Harvey", "Williamson",
        "Gilbert", "Dean", "Sims", "Howell", "Reid", "Hanson", "McCoy", "Garrett", "Burton", "Fuller",
        "Weber", "Welch", "Lucas", "Fields", "Little", "Banks", "Day", "Walsh", "Bowman", "Schultz",
        "Fowler", "Davidson", "Brewer", "May", "Holland", "Newman", "Pearson", "Curtis", "Douglas", "Schneider",
        "Joseph", "Barrett", "Keller", "Wade", "Stanley", "Hopkins", "Barnett", "Bates", "Chambers", "Caldwell",
        "Beck", "Lambert", "Byrd", "Craig", "Lowe", "Frazier", "Powers", "Leonard", "McGuire", "Allison",
        "Mullins", "Goodwin", "Ball", "Thornton", "Mann", "Underwood", "Bass", "Greer", "Sutton", "Keith",
        "Holt", "Tate", "Hodges", "Moss", "Pratt", "McCann", "Gallagher", "Horn", "Briggs", "Sharp",
        "Ware", "Buck", "Barton", "Joyner", "Webster", "Lindsey", "Parrish", "Gibbons", "Crosby", "Holbrook",
        "Conner", "Pugh", "Golden", "Morse", "Whitaker", "Stanton", "Olsen", "Hartman", "Vance", "Savage",
        "Tomlinson", "Nash", "Winters", "Roth", "Meyers", "Robbins", "Schwartz", "Saunders", "Wise", "Colon",
        "Gill", "Cannon", "Bruce", "Clayton", "Gross", "Pierson", "Driscoll", "Oconnor", "Pittman", "Conley",
        "Love", "Mahoney", "Mcconnell", "Wall", "Bowen", "Brennan", "Middleton", "Hancock", "Stokes", "Ramsey",
        "Gorman", "Cummins", "Moody", "Vaughn", "Walter", "Carey", "Hooper", "Manning", "Goodman", "Stevenson",
        "Bauer", "Duffy", "Dalton", "Horton", "Graves", "Wilkins", "Kenny", "Harmon", "Mcintyre", "Booth",
        "Malone", "Yates", "Becker", "Roach", "Knapp", "Neal", "Copeland", "Cooke", "Norton", "Mueller",
        "Gay", "Moran", "Fletcher", "Johns", "Shields", "Moon", "Lin", "Stout", "Osborn", "Werner",
        "Booker", "Clay", "Bruno", "Barr", "Ivy", "Abbott", "House", "Atwood", "Wolf", "Jefferson",
        "Church", "Conrad", "Decker", "Bird", "Houston", "Sherman", "Walls", "Knox", "York", "Browning",
        "Compton", "Larsen", "Bentley", "Rollins", "Clements", "Galloway", "Brock", "Kane", "Benton", "Joyce",
        "Buckley", "Valentine", "Maddox", "Mckenzie", "Mcmillan", "Berg", "Dotson", "Mays", "Chan", "Richmond",
        "Meadows", "Faulkner", "O'Neill", "Kline", "Barry", "Jacobson", "Avery", "Hendricks", "Horne", "Shepard",
        "Hebert", "Cherry", "Whitney", "Waller", "Holman", "Donaldson", "Terrell", "Morin", "Gillespie", "Tillman",
        "Sanford", "Peck", "Key", "Gamble", "Dickson", "Battle", "Cabrera", "Cervantes", "Howe", "Hinton",
        "Hurley", "Spence", "Mcneil", "Case", "Petty", "Gould", "Mcfarland", "Sampson", "Carver", "Bray",
        "Macdonald", "Hester", "Dillon", "Farley", "Hopper", "Potts", "Bernard", "Aguirre", "Mercer", "Bender",
        "Rowland", "Sykes", "Benjamin", "Travis", "Pickett", "Crane", "Sears", "Mayo", "Dunlap", "Hayden",
        "Wilder", "Mckay", "Coffey", "Mccarty", "Ewing", "Cooley", "Vaughan", "Bonner", "Cotton", "Holder",
        "Stark", "Ferrell", "Cantrell", "Fulton", "Lynn", "Lott", "Rosa", "Pollard", "Burch", "Mullen",
        "Fry", "Riddle", "Levy", "David", "Duke", "O'Donnell", "Grey", "Mccormick", "Noble", "Shelton",
        "Rush", "Yoder", "Rankin", "Hamlin", "Reeves", "Anthony", "Dickerson", "Zuniga", "Farmer", "Kidd",
        "Good", "Fleming", "Durham", "Rutledge", "Dennis", "Walton", "Watts", "Koch", "Grimes", "Rich",
        "Weiss", "Bartlett", "Krueger", "Doyle", "Alston", "Dyer", "Glass", "Rowe", "Kuhn", "Shaffer",
        "Bradshaw", "Cummings", "English", "Kirby", "Reilly", "Patrick", "Goddard", "Major", "Holcomb", "Hoover",
        "Tanner", "Glover", "Buchanan", "Schwab", "Walters", "Bush", "Shepherd", "Snow",
        
        # Spanish surnames
        "Garcia", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Perez", "Sanchez", "Ramirez", "Torres",
        "Flores", "Rivera", "Gomez", "Diaz", "Cruz", "Reyes", "Morales", "Gutierrez", "Ortiz", "Ramos",
        "Chavez", "Mendoza", "Ruiz", "Alvarez", "Castillo", "Vasquez", "Romero", "Herrera", "Medina", "Aguilar",
        "Jimenez", "Vargas", "Castro", "Fernandez", "Guzman", "Munoz", "Salazar", "Padilla", "Guerrero", "Delgado",
        "Contreras", "Sandoval", "Estrada", "Ortega", "Nunez", "Valdez", "Santiago", "Maldonado", "Dominguez", "Espinoza",
        "Vega", "Rojas", "Marquez", "Luna", "Mejia", "Juarez", "Figueroa", "Avila", "Molina", "Campos",
        "Navarro", "Ayala", "Lara", "Alonso", "Moreno", "Rios", "Pena", "Soto", "Acosta", "Cortez",
        "Silva", "Lozano", "Benitez", "Valencia", "Meza", "Hensley", "Macias", "Carson", "Cardenas", "Trujillo",
        "Ochoa", "Cantu", "Fuentes", "Santana", "Zamora", "Suarez", "Rosario", "Melendez", "Salas", "Cabral",
        "Sepulveda", "Escalante", "Bautista", "Velasco", "Carrillo", "Mendez", "Solis", "Lemus", "Robles", "Espino",
        "Gallegos", "Cordova", "Parra", "Velazquez", "Montoya", "Serrano", "Calderon", "Arroyo", "Villarreal", "Caballero",
        "Duran", "Galvan", "Montes", "Villalobos", "Mora", "Esquivel", "Hidalgo", "Pacheco", "Cervera", "Quinones",
        "Deleon", "Elizondo", "Mata", "Godinez", "Palacios", "Mercado", "Quintero", "Uribe", "Enriquez", "Bermudez",
        "Espinosa", "Coronado", "Barrera", "Alarcon", "Salinas", "Ibarra", "Pantoja", "Cano", "Valenzuela", "Salgado",
        "Vergara", "Franco", "Orozco", "Bonilla", "Montero", "Prieto", "Escobar", "Heredia", "Toledo", "Gallardo",
        "Galindo", "Acevedo", "Cuevas", "Carrasco", "Paredes", "Villegas", "Venegas", "Zuniga", "Amaya", "Tovar",
        "Cuellar", "Portillo", "Aguirre", "Solano", "Calderon", "Peralta", "Camacho", "Cervantes", "Medrano", "Alcala",
        "Narvaez", "Rangel", "Arellano", "Segura", "Serna", "Osorio", "Ceballos", "Ojeda", "Villanueva", "Villareal",
        "Murillo", "Hurtado", "Davila", "Nava", "Alfaro", "Andrade", "Aviles", "Cisneros", "Echevarria", "Lucero",
        "Pineda", "Rosales", "Saenz", "Varela", "Villasenor", "Zavala", "Alcantara", "Armendariz", "Beltran", "Casas",
        "Castellanos", "Fierro", "Huerta", "Jaramillo", "Jaimes", "Lugo", "Marin", "Nieto", "Ocampo", "Ornelas",
        "Palma", "Plata", "Quiroz", "Rivas", "Rocha", "Rubio", "Soriano", "Tirado", "Urbina", "Vidal",
        "Aguayo", "Bravo", "Bustamante", "Campuzano", "Carbajal", "Cardona", "Carmona", "Carvajal", "Casillas", "Celis",
        "Cepeda", "Cordero", "Cortes", "Crespo", "Curiel", "De La Torre", "De Los Santos", "Delacruz", "Delrio", "Duarte",
        "Falcon", "Favela", "Galicia", "Gaona", "Garay", "Gil", "Giron", "Guerra", "Guillen", "Guzman",
        "Herrera", "Ibanez", "Izquierdo", "Leal", "Leon", "Lira", "Loera", "Lomeli", "Mancilla", "Manzo",
        "Marcelo", "Mariscal", "Mayorga", "Melchor", "Meza", "Miranda", "Mondragon", "Montano", "Montemayor", "Morales",
        "Naranjo", "Olivares", "Olivera", "Ontiveros", "Ordaz", "Orozco", "Otero", "Ponce", "Portillo", "Quezada",
        "Quintana", "Ramos", "Regalado", "Renteria", "Restrepo", "Reynoso", "Rico", "Robledo", "Rocha", "Romero",
        "Rosario", "Rueda", "Ruiz", "Salcedo", "Saldivar", "Santoyo", "Segovia", "Sillas", "Soberon", "Sosa",
        "Tapia", "Tavares", "Tejada", "Tellez", "Urias", "Vaca", "Valdovinos", "Valle", "Vega", "Vera",
        "Vergara", "Villa", "Villalon", "Vizcarra", "Yanez", "Zapata", "Zaragoza", "Zelaya", "Zepeda", "Zurita",
        
        # Arabic surnames
        "Ahmed", "Ali", "Hassan", "Mohamed", "Abdullah", "Ibrahim", "Mahmoud", "Omar", "Youssef", "Khalil",
        "Salem", "Farid", "Nasser", "Rashid", "Karim", "Zayed", "Mansour", "Hamid", "Saeed", "Ismail",
        "Taha", "Mubarak", "Hakim", "Sharif", "Qasim", "Zakaria", "Wahab", "Badawi", "Baghdadi", "Najjar",
        "Sabbagh", "Khatib", "Hammoud", "Khoury", "Nassar", "Haddad", "Kasem", "Aziz", "Habib", "Ghanem",
        "Awad", "Mansouri", "Darwish", "Halabi", "Saleh", "Shami", "Jaber", "Abboud", "Salim", "Qadri",
        "Sayegh", "Tawfik", "Assaf", "Dabbas", "Fares", "Ghazi", "Hasan", "Mahdi", "Nadir", "Odeh",
        "Ramadan", "Samara", "Tamimi", "Umar", "Yasser", "Zain", "Amir", "Bashar", "Emad", "Faisal",
        "Hatem", "Jamal", "Marwan", "Tariq", "Waleed", "Yassin", "Adnan", "Bilal", "Fouad", "Mazen",
        "Nabil", "Rami", "Samir", "Wael", "Abbas", "Bahaa", "Diyaa", "Essam", "Ghaith", "Hazem",
        "Iyad", "Jihad", "Khalid", "Loai", "Maher", "Nader", "Osama", "Ramy", "Shady", "Talal",
        
        # Asian surnames (Chinese, Korean, Japanese, Vietnamese, Indian)
        "Chen", "Wang", "Li", "Zhang", "Liu", "Yang", "Huang", "Zhao", "Wu", "Zhou",
        "Xu", "Sun", "Ma", "Zhu", "Hu", "Guo", "He", "Lin", "Gao", "Luo",
        "Zheng", "Liang", "Xie", "Song", "Tang", "Xu", "Han", "Feng", "Deng", "Cao",
        "Peng", "Zeng", "Xiao", "Tian", "Dong", "Pan", "Yuan", "Cai", "Jiang", "Yu",
        "Du", "Ye", "Cheng", "Wei", "Ren", "Lu", "Jin", "Qin", "Shi", "Cui",
        "Tan", "Lu", "Fan", "Wang", "Meng", "Bai", "Qiu", "Zou", "Xiong", "Chang",
        "Shi", "Kong", "Shao", "Hao", "Mao", "Lai", "Wen", "Fang", "Yin", "Qian",
        "Park", "Kim", "Lee", "Choi", "Jung", "Kang", "Cho", "Yoon", "Jang", "Lim",
        "Han", "Oh", "Seo", "Shin", "Kwon", "Hwang", "Ahn", "Song", "Yoo", "Hong",
        "Jeon", "Go", "Moon", "Son", "Yang", "Baek", "Heo", "Gang", "Cheon", "Nam",
        "Ryu", "Yun", "Noh", "Sim", "Won", "Kwak", "Min", "Cha", "Joo", "Huh",
        "Yamamoto", "Tanaka", "Suzuki", "Watanabe", "Ito", "Nakamura", "Kobayashi", "Kato", "Yoshida", "Yamada",
        "Sasaki", "Yamaguchi", "Saito", "Matsumoto", "Inoue", "Kimura", "Hayashi", "Shimizu", "Yamazaki", "Mori",
        "Abe", "Ikeda", "Hashimoto", "Yamashita", "Ishikawa", "Nakajima", "Maeda", "Fujita", "Ogawa", "Goto",
        "Okada", "Hasegawa", "Murakami", "Kondo", "Ishii", "Saito", "Sakamoto", "Endo", "Aoki", "Fujii",
        "Nishida", "Fukuda", "Ota", "Miura", "Takeuchi", "Nakagawa", "Okamoto", "Matsuda", "Nakano", "Harada",
        "Nguyen", "Tran", "Le", "Pham", "Hoang", "Huynh", "Vo", "Dang", "Bui", "Do",
        "Ho", "Ngo", "Duong", "Ly", "Vu", "Trinh", "Phan", "Lam", "Mai", "Cao",
        "Dinh", "Luong", "Ta", "Truong", "Quach", "Tong", "Chau", "Ong", "Luu", "Dam",
        "Patel", "Singh", "Kumar", "Sharma", "Gupta", "Agarwal", "Jain", "Bansal", "Shah", "Mehta",
        "Verma", "Agrawal", "Goyal", "Mittal", "Joshi", "Yadav", "Mishra", "Tiwari", "Srivastava", "Saxena",
        "Pandey", "Chouhan", "Rajput", "Thakur", "Chauhan", "Varma", "Kapoor", "Malhotra", "Khanna", "Bhatia",
        "Arora", "Sethi", "Chopra", "Goel", "Sood", "Anand", "Singhal", "Bhardwaj", "Rastogi", "Aggarwal",
        
        # European surnames (German, French, Italian, Irish, Polish, etc.)
        "Mueller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann",
        "Schafer", "Koch", "Bauer", "Richter", "Klein", "Wolf", "Schroeder", "Neumann", "Schwarz", "Zimmermann",
        "Braun", "Krueger", "Hartmann", "Lange", "Schmitt", "Werner", "Schmitz", "Krause", "Meier", "Lehmann",
        "Vogel", "Friedrich", "Keller", "Jung", "Hahn", "Schubert", "Winkler", "Berger", "Henkel", "Fuchs",
        "Martin", "Bernard", "Dubois", "Thomas", "Robert", "Richard", "Petit", "Durand", "Leroy", "Moreau",
        "Simon", "Laurent", "Lefebvre", "Michel", "Garcia", "David", "Bertrand", "Roux", "Vincent", "Fournier",
        "Morel", "Girard", "Andre", "Lefevre", "Mercier", "Dupont", "Lambert", "Bonnet", "Francois", "Martinez",
        "Legrand", "Garnier", "Faure", "Rousseau", "Blanc", "Guerin", "Muller", "Henry", "Roussel", "Nicolas",
        "Rossi", "Russo", "Ferrari", "Esposito", "Bianchi", "Romano", "Colombo", "Ricci", "Marino", "Greco",
        "Bruno", "Gallo", "Conti", "De Luca", "Mancini", "Costa", "Giordano", "Rizzo", "Lombardi", "Moretti",
        "Barbieri", "Fontana", "Santoro", "Mariani", "Rinaldi", "Caruso", "Ferrara", "Galli", "Martini", "Leone",
        "O'Brien", "O'Sullivan", "O'Connor", "O'Neill", "O'Reilly", "Murphy", "Kelly", "Sullivan", "Walsh", "Smith",
        "O'Rourke", "Ryan", "Doyle", "McCarthy", "Gallagher", "O'Doherty", "Kennedy", "Lynch", "Murray", "Quinn",
        "Moore", "McLaughlin", "Carroll", "Connolly", "Daly", "Connell", "Wilson", "Dunne", "Clarke", "Byrne",
        "Kowalski", "Nowak", "Wisniewski", "Wojcik", "Kowalczyk", "Kaminski", "Lewandowski", "Zielinski", "Szymanski", "Wozniak",
        "Dabrowski", "Kozlowski", "Jankowski", "Mazur", "Kwiatkowski", "Krawczyk", "Piotrowski", "Grabowski", "Nowakowski", "Pawlowski",
        "Michalski", "Nowicki", "Adamczyk", "Dudek", "Zajac", "Wieczorek", "Jablonski", "Krol", "Majewski", "Olszewski",
        "Anderson", "Johansson", "Karlsson", "Nilsson", "Eriksson", "Larsson", "Olsson", "Persson", "Svensson", "Gustafsson",
        "Pettersson", "Jonsson", "Jansson", "Hansson", "Bengtsson", "Jorgensen", "Madsen", "Kristensen", "Nielsen", "Christensen",
        "Rasmussen", "Hansen", "Thomsen", "Jakobsen", "Olsen", "Johannsen", "Moller", "Mortensen", "Nielsen", "Sorensen",
        
        # African surnames
        "Abubakar", "Adebayo", "Adediran", "Adegoke", "Adeleye", "Adeniran", "Adeyemi", "Agbaje", "Ajayi", "Akinola",
        "Akintola", "Alabi", "Babatunde", "Balogun", "Dare", "Dosunmu", "Egbewole", "Fawole", "Gbadamosi", "Idowu",
        "Kano", "Lawal", "Makinde", "Ogundipe", "Ogundimu", "Oguntola", "Oladele", "Olatunji", "Olayemi", "Onwuka",
        "Osoba", "Oyewole", "Salako", "Tejuoso", "Yusuf", "Zubair", "Nkomo", "Ngozi", "Okafor", "Okwu",
        "Van Der Merwe", "Van Der Walt", "Botha", "Pretorius", "Coetzee", "Nel", "Meyer", "Fourie", "Kruger", "Steyn",
        "Venter", "Du Plessis", "Jooste", "Le Roux", "Van Zyl", "Potgieter", "Swanepoel", "Muller", "Bekker", "Strydom",
        "Mthembu", "Dlamini", "Nkomo", "Mokoena", "Molefe", "Mogale", "Mabena", "Mashego", "Mahlangu", "Mabuza",
        "Nkosi", "Sithole", "Zulu", "Xaba", "Vilakazi", "Thwala", "Shabangu", "Radebe", "Zungu", "Mazibuko",
        
        # Middle Eastern and North African surnames
        "Al-Ahmad", "Al-Ali", "Al-Hassan", "Al-Hussein", "Al-Mahmoud", "Al-Rashid", "Al-Zahra", "Bin Ahmed", "Bin Ali", "Bin Hassan",
        "El-Masri", "El-Khoury", "El-Haddad", "El-Zein", "Abou-Khalil", "Abu-Nasser", "Ben-Ahmed", "Ben-Ali", "Ben-Mohamed", "Ibn-Rashid",
        "Abdallah", "Abdel-Rahman", "Abdul-Aziz", "Abdul-Karim", "Abdul-Latif", "Abdul-Malik", "Abdul-Rahman", "Abdul-Wahab", "Abou-Zeid", "Al-Anwar",
        "Al-Ansari", "Al-Bakri", "Al-Farisi", "Al-Halabi", "Al-Hashimi", "Al-Jabiri", "Al-Kindi", "Al-Maktoum", "Al-Najjar", "Al-Omari",
        "Al-Qasimi", "Al-Sabah", "Al-Thani", "Al-Zahed", "Bin-Laden", "El-Alfy", "El-Shafei", "Ibn-Sina", "Qadri", "Sabbagh",
        
        # Brazilian and Portuguese surnames
        "Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Alves", "Pereira", "Lima", "Gomes",
        "Ribeiro", "Carvalho", "Almeida", "Lopes", "Soares", "Fernandes", "Vieira", "Barbosa", "Rocha", "Dias",
        "Monteiro", "Mendes", "Freitas", "Cardoso", "Ramos", "Araujo", "Cavalcanti", "Azevedo", "Castro", "Nascimento",
        "Machado", "Reis", "Moreira", "Campos", "Nunes", "Teixeira", "Correia", "Marques", "Pinto", "Farias",
        
        # Scandinavian surnames
        "Lindberg", "Lindqvist", "Lindstrom", "Lundberg", "Lundgren", "Sandberg", "Forsberg", "Hedberg", "Henriksson", "Martinson",
        "Petersson", "Samuelsson", "Danielsson", "Engstrom", "Holmberg", "Lind", "Holm", "Berg", "Dahl", "Strand",
        "Haugen", "Knudsen", "Andersen", "Pedersen", "Hagen", "Johansen", "Olsen", "Larsen", "Solberg", "Moen",
        
        # Eastern European surnames
        "Novak", "Horvath", "Varga", "Toth", "Kiss", "Molnar", "Nemeth", "Farkas", "Balogh", "Papp",
        "Takacs", "Juhasz", "Lakatos", "Meszaros", "Olah", "Simon", "Racz", "Fekete", "Szucs", "Bogdan",
        "Popescu", "Ionescu", "Popa", "Radu", "Stoica", "Constantin", "Gheorghe", "Marin", "Nicolaescu", "Dima",
        "Petrov", "Ivanov", "Sidorov", "Smirnov", "Kuznetsov", "Popov", "Volkov", "Petrov", "Mikhailov", "Fedorov",
        "Morozov", "Volkov", "Alekseev", "Lebedev", "Semenov", "Egorov", "Titov", "Olegov", "Borisov", "Artemov",
        
        # Caribbean and Latin American surnames
        "Baptiste", "Jean-Baptiste", "Pierre", "Joseph", "Charles", "Antoine", "Louis", "Michel", "Gabriel", "Emmanuel",
        "Desir", "Hyppolite", "Augustin", "Innocent", "Celestin", "Casimir", "Compere", "Morancy", "Philogene", "Volcy",
        "Batista", "Cabrera", "Herrera", "Jimenez", "Morales", "Ortiz", "Ramirez", "Ramos", "Rivera", "Rodriguez",
        "Vargas", "Villalobos", "Zuniga", "Machado", "Montoya", "Moreno", "Munoz", "Navarro", "Ortega", "Paredes",
        
        # Additional diverse surnames from various origins
        "Abernathy", "Ackerman", "Aldridge", "Appleby", "Ashford", "Atkinson", "Blackwood", "Calloway", "Chandler", "Cornwell",
        "Crenshaw", "Dalton", "Eastwood", "Fairfax", "Garrett", "Harrington", "Holloway", "Ingram", "Jarvis", "Kendrick",
        "Langford", "Manning", "Norwood", "Osborne", "Pemberton", "Quincy", "Radford", "Stafford", "Thornfield", "Underhill",
        "Vanderbilt", "Westbrook", "Whitfield", "Yorktown", "Zealand", "Abernethy", "Beaumont", "Chesterfield", "Dunmore", "Elmsworth",
        "Fairchild", "Greenfield", "Hawthorne", "Kensington", "Lexington", "Montgomery", "Northfield", "Pembroke", "Redfield", "Southfield",
        "Thornton", "Winchester", "Abercrombie", "Blackstone", "Chesterton", "Downshire", "Elmwood", "Fairfield", "Glastonbury", "Hartwell",
        "Kenmore", "Lockwood", "Middleton", "Newfield", "Oldbridge", "Parkfield", "Queensbury", "Redwood", "Springfield", "Thornbury",
        "Upfield", "Westfield", "Yorkfield", "Zellwood", "Ashfield", "Brookfield", "Clearfield", "Deerfield", "Elmfield", "Fairwood",
        "Greenwood", "Heatherfield", "Ironwood", "Juniper", "Kentwood", "Lakewood", "Maplewood", "Northwood", "Oakfield", "Pinewood",
        "Quailwood", "Ridgewood", "Sherwood", "Tanglewood", "Underwood", "Valewood", "Whitewood", "Yarrow", "Zebrawood", "Acornfield"
    )
    
    # Array of first initials
    $FirstInitials = @(
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    )
    
    # Standard Windows user profile subfolders
    $UserSubFolders = @(
        "Desktop", "Documents", "Downloads", "AppData", "Contacts", 
        "Favorites", "Links", "Music", "OneDrive", "Pictures", 
        "Saved Games", "Searches", "Videos"
    )
    
    # Password generation function
    function Generate-RandomPassword {
        param(
            [int]$MinLength = 8,
            [int]$MaxLength = 10
        )
        
        $PasswordLength = Get-Random -Minimum $MinLength -Maximum ($MaxLength + 1)
        
        # Character sets for password generation
        $LowerCase = 'abcdefghijklmnopqrstuvwxyz'
        $UpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        $Numbers = '0123456789'
        $SpecialChars = '!@#$%^&*'
        
        $AllChars = ($LowerCase + $UpperCase + $Numbers + $SpecialChars).ToCharArray()
        
        # Generate random password
        $Password = -join ((1..$PasswordLength) | ForEach-Object { Get-Random -InputObject $AllChars })
        
        return $Password
    }
    
    # Function to generate random credential filename
    function Get-RandomCredentialFilename {
        param([string]$Username)
        
        $FilenameOptions = @(
            "login.txt",
            "password.txt",
            "$Username's password.txt",
            "credentials.txt",
            "account.txt",
            "user_pass.txt",
            "access.txt",
            "my_login.txt",
            "signin.txt",
            "auth.txt",
            "logon.txt",
            "user_info.txt",
            "account_details.txt",
            "personal_info.txt",
            "security.txt",
            "profile.txt",
            "user_credentials.txt",
            "my_password.txt",
            "login_info.txt",
            "access_codes.txt"
        )
        
        return Get-Random -InputObject $FilenameOptions
    }
    
    # Array of 50 Wikipedia image URLs with descriptive names
    $WikipediaImages = @(
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png/256px-Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png"; Name = "wild_cat.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/256px-American_Beaver.jpg"; Name = "american_beaver.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Padlock-silver.svg/256px-Padlock-silver.svg.png"; Name = "silver_padlock.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Ben_Clock_Face.jpg/256px-Big_Ben_Clock_Face.jpg"; Name = "big_ben_clock.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/256px-Gull_portrait_ca_usa.jpg"; Name = "seagull_portrait.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Colosseo_2020.jpg/256px-Colosseo_2020.jpg"; Name = "rome_colosseum.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Paris_Night.jpg/256px-Paris_Night.jpg"; Name = "paris_at_night.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg/256px-Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg"; Name = "mount_everest.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Collage_of_Six_Cats-02.jpg/256px-Collage_of_Six_Cats-02.jpg"; Name = "six_cats_collage.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/256px-Cat03.jpg"; Name = "orange_tabby_cat.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Vd-Orig.png/256px-Vd-Orig.png"; Name = "abstract_pattern.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Earth_Eastern_Hemisphere.jpg/256px-Earth_Eastern_Hemisphere.jpg"; Name = "earth_eastern_hemisphere.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Altocumulus_mackerel_sky.jpg/256px-Altocumulus_mackerel_sky.jpg"; Name = "mackerel_sky_clouds.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/256px-PNG_transparency_demonstration_1.png"; Name = "transparency_demo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Albert_Einstein_%28Nobel%29.png/256px-Albert_Einstein_%28Nobel%29.png"; Name = "albert_einstein.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/256px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg"; Name = "starry_night_van_gogh.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/The_Great_Wave_off_Kanagawa.jpg/256px-The_Great_Wave_off_Kanagawa.jpg"; Name = "great_wave_kanagawa.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/256px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg"; Name = "mona_lisa.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Ultraviolet_image_of_the_Cygnus_Loop_Nebula_crop.jpg/256px-Ultraviolet_image_of_the_Cygnus_Loop_Nebula_crop.jpg"; Name = "cygnus_loop_nebula.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_Earth_seen_from_Apollo_17.jpg/256px-The_Earth_seen_from_Apollo_17.jpg"; Name = "earth_from_space_apollo17.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Domestic_goat_kid_in_capeweed.jpg/256px-Domestic_goat_kid_in_capeweed.jpg"; Name = "baby_goat_in_flowers.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/256px-Cat_November_2010-1a.jpg"; Name = "brown_white_cat.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/256px-Red_Apple.jpg"; Name = "red_apple.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Basketball.png/256px-Basketball.png"; Name = "basketball.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Sunflower_sky_backdrop.jpg/256px-Sunflower_sky_backdrop.jpg"; Name = "sunflower_field.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/ECB-2002-10_EUR_-_Obverse.png/256px-ECB-2002-10_EUR_-_Obverse.png"; Name = "10_euro_note.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/46_queen_elizabeth_2_stamp.jpg/256px-46_queen_elizabeth_2_stamp.jpg"; Name = "queen_elizabeth_stamp.jpg" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Square_-_black_simple.svg/256px-Square_-_black_simple.svg.png"; Name = "black_square.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Wikipedia-logo-en-big.png/256px-Wikipedia-logo-en-big.png"; Name = "wikipedia_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/256px-Apple_logo_black.svg.png"; Name = "apple_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/256px-Google_2015_logo.svg.png"; Name = "google_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Coca-Cola_logo.svg/256px-Coca-Cola_logo.svg.png"; Name = "coca_cola_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/256px-Amazon_logo.svg.png"; Name = "amazon_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/256px-Facebook_f_logo_%282019%29.svg.png"; Name = "facebook_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Twitter-logo.svg/256px-Twitter-logo.svg.png"; Name = "twitter_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Logo_of_YouTube_%282015-2017%29.svg/256px-Logo_of_YouTube_%282015-2017%29.svg.png"; Name = "youtube_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/256px-LinkedIn_logo_initials.png"; Name = "linkedin_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Android_O_Preview_Logo.png/256px-Android_O_Preview_Logo.png"; Name = "android_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Windows_logo_-_2012.svg/256px-Windows_logo_-_2012.svg.png"; Name = "windows_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Samsung_Logo.svg/256px-Samsung_Logo.svg.png"; Name = "samsung_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/CSS3_logo_and_wordmark.svg/256px-CSS3_logo_and_wordmark.svg.png"; Name = "css3_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/HTML5_logo_and_wordmark.svg/256px-HTML5_logo_and_wordmark.svg.png"; Name = "html5_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Unofficial_JavaScript_logo_2.svg/256px-Unofficial_JavaScript_logo_2.svg.png"; Name = "javascript_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/256px-Python-logo-notext.svg.png"; Name = "python_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/ISO_C%2B%2B_Logo.svg/256px-ISO_C%2B%2B_Logo.svg.png"; Name = "cpp_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Node.js_logo.svg/256px-Node.js_logo.svg.png"; Name = "nodejs_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/256px-React-icon.svg.png"; Name = "react_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Vue.js_Logo_2.svg/256px-Vue.js_Logo_2.svg.png"; Name = "vuejs_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Angular_full_color_logo.svg/256px-Angular_full_color_logo.svg.png"; Name = "angular_logo.png" },
        @{ URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/256px-Ruby_logo.svg.png"; Name = "ruby_logo.png" }
    )
    
    # Function to download random images for a user
    function Download-RandomImages {
        param(
            [string]$PicturesPath,
            [string]$Username
        )
        
        $ImageCount = Get-Random -Minimum 5 -Maximum 16
        $SelectedImages = Get-Random -InputObject $WikipediaImages -Count $ImageCount
        
        Write-Host "  Downloading $ImageCount images for $Username..." -ForegroundColor Yellow
        
        foreach ($ImageData in $SelectedImages) {
            try {
                $ImageUrl = $ImageData.URL
                $FileName = $ImageData.Name
                $FilePath = Join-Path -Path $PicturesPath -ChildPath $FileName
                
                Invoke-WebRequest -Uri $ImageUrl -OutFile $FilePath -TimeoutSec 10 -ErrorAction SilentlyContinue
            }
            catch {
                Write-Warning "Failed to download $($ImageData.Name) for $Username"
            }
        }
    }
    
    # Function to generate random API key
    function Generate-RandomAPIKey {
        param([string]$ServiceType = "generic")
        
        switch ($ServiceType) {
            "openai" { 
                $prefix = "sk-"
                $length = 48
            }
            "stripe" { 
                $prefix = "sk_live_"
                $length = 32
            }
            "aws" { 
                $prefix = "AKIA"
                $length = 16
            }
            "azure" { 
                $prefix = ""
                $length = 32
            }
            "gcp" { 
                $prefix = ""
                $length = 39
            }
            "paypal" { 
                $prefix = "AQ"
                $length = 78
            }
            default { 
                $prefix = ""
                $length = 32
            }
        }
        
        $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        $randomString = -join ((1..($length - $prefix.Length)) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
        
        return $prefix + $randomString
    }
    
    # Function to create random API key JSON file
    function Create-APIKeyFile {
        param(
            [string]$DocumentsPath,
            [string]$Username
        )
        
        $APIServices = @(
            @{ 
                Service = "OpenAI"; Type = "openai"; 
                Patterns = @("openai_api_key.json", "chatgpt_key.json", "openai_secret.json", "ai_api_credentials.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "organization" = "org-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Stripe"; Type = "stripe"; 
                Patterns = @("stripe_api_key.json", "stripe_secret.json", "payment_keys.json", "stripe_credentials.json")
                JSONTemplate = @{
                    "secret_key" = ""
                    "publishable_key" = "pk_live_" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "webhook_secret" = "whsec_" + (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "PayPal"; Type = "paypal"; 
                Patterns = @("paypal_api_key.json", "paypal_credentials.json", "paypal_secret.json", "payment_api.json")
                JSONTemplate = @{
                    "client_id" = ""
                    "client_secret" = (-join ((1..64) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "mode" = "live"
                }
            },
            @{ 
                Service = "AWS"; Type = "aws"; 
                Patterns = @("aws_api_key.json", "amazon_credentials.json", "aws_secret.json", "cloud_keys.json")
                JSONTemplate = @{
                    "AccessKeyId" = ""
                    "SecretAccessKey" = (-join ((1..40) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(43, 47) | Get-Random) }))
                    "Region" = @("us-east-1", "us-west-2", "eu-west-1", "ap-southeast-1") | Get-Random
                }
            },
            @{ 
                Service = "Azure"; Type = "azure"; 
                Patterns = @("azure_api_key.json", "microsoft_credentials.json", "azure_secret.json", "azure_keys.json")
                JSONTemplate = @{
                    "subscription_id" = [guid]::NewGuid().ToString()
                    "client_id" = [guid]::NewGuid().ToString()
                    "client_secret" = ""
                    "tenant_id" = [guid]::NewGuid().ToString()
                }
            },
            @{ 
                Service = "GCP"; Type = "gcp"; 
                Patterns = @("gcp_api_key.json", "google_cloud_key.json", "gcp_credentials.json", "google_api.json")
                JSONTemplate = @{
                    "type" = "service_account"
                    "project_id" = "my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) }))
                    "private_key_id" = (-join ((1..40) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "private_key" = "-----BEGIN PRIVATE KEY-----`nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC..." + (-join ((1..50) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) + "`n-----END PRIVATE KEY-----"
                    "client_email" = "service-account@my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) })) + ".iam.gserviceaccount.com"
                    "client_id" = (-join ((1..21) | ForEach-Object { [char](48..57 | Get-Random) }))
                }
            },
            @{ 
                Service = "Square"; Type = "generic"; 
                Patterns = @("square_api_key.json", "square_credentials.json", "square_secret.json", "pos_api.json")
                JSONTemplate = @{
                    "application_id" = "sq0idp-" + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "access_token" = ""
                    "environment" = "production"
                    "location_id" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Claude"; Type = "generic"; 
                Patterns = @("claude_api_key.json", "anthropic_key.json", "claude_credentials.json", "anthropic_api.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "model" = "claude-3-sonnet-20240229"
                    "max_tokens" = 4096
                }
            },
            @{ 
                Service = "Verkada"; Type = "generic"; 
                Patterns = @("verkada_api_key.json", "verkada_credentials.json", "camera_api.json", "verkada_secret.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "org_id" = (-join ((1..8) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..12) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "base_url" = "https://api.verkada.com"
                }
            },
            @{ 
                Service = "YouTube"; Type = "generic"; 
                Patterns = @("youtube_api_key.json", "google_youtube_key.json", "youtube_credentials.json", "video_api.json")
                JSONTemplate = @{
                    "api_key" = ""
                    "quota_user" = $Username
                    "part" = @("snippet", "statistics", "contentDetails")
                }
            },
            @{ 
                Service = "Twilio"; Type = "generic"; 
                Patterns = @("twilio_api_key.json", "sms_api_key.json", "twilio_credentials.json", "messaging_api.json")
                JSONTemplate = @{
                    "account_sid" = "AC" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "auth_token" = ""
                    "api_key" = "SK" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "api_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "SendGrid"; Type = "generic"; 
                Patterns = @("sendgrid_api_key.json", "email_api_key.json", "sendgrid_secret.json", "mail_credentials.json")
                JSONTemplate = @{
                    "api_key" = "SG." + (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) })) + "." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "from_email" = "noreply@" + (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".com"
                }
            },
            @{ 
                Service = "Shopify"; Type = "generic"; 
                Patterns = @("shopify_api_key.json", "store_credentials.json", "ecommerce_api.json", "shopify_secret.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "password" = ""
                    "shared_secret" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                    "shop_domain" = (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".myshopify.com"
                }
            },
            @{ 
                Service = "Discord"; Type = "generic"; 
                Patterns = @("discord_bot_token.json", "discord_api_key.json", "bot_credentials.json", "discord_secret.json")
                JSONTemplate = @{
                    "bot_token" = ""
                    "client_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
                    "client_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "guild_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
                }
            },
            @{ 
                Service = "Slack"; Type = "generic"; 
                Patterns = @("slack_api_key.json", "slack_bot_token.json", "workspace_credentials.json", "slack_webhook.json")
                JSONTemplate = @{
                    "bot_token" = "xoxb-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "app_token" = "xapp-1-" + (-join ((1..11) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..64) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                    "webhook_url" = "https://hooks.slack.com/services/T" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/B" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "GitHub"; Type = "generic"; 
                Patterns = @("github_token.json", "git_credentials.json", "repo_access_token.json", "github_api_key.json")
                JSONTemplate = @{
                    "token" = "ghp_" + (-join ((1..36) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                    "username" = $Username
                    "scope" = @("repo", "user", "admin:org")
                }
            },
            @{ 
                Service = "GitLab"; Type = "generic"; 
                Patterns = @("gitlab_token.json", "gitlab_api_key.json", "git_access_token.json", "gitlab_credentials.json")
                JSONTemplate = @{
                    "access_token" = "glpat-" + (-join ((1..20) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "username" = $Username
                    "gitlab_url" = "https://gitlab.com"
                }
            },
            @{ 
                Service = "Dropbox"; Type = "generic"; 
                Patterns = @("dropbox_api_key.json", "storage_credentials.json", "dropbox_token.json", "file_api_key.json")
                JSONTemplate = @{
                    "access_token" = "sl." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "app_key" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                    "app_secret" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                }
            },
            @{ 
                Service = "Mailchimp"; Type = "generic"; 
                Patterns = @("mailchimp_api_key.json", "email_marketing_key.json", "mailchimp_secret.json", "campaign_api.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-us1"
                    "server" = "us1"
                    "username" = $Username
                }
            },
            @{ 
                Service = "Zoom"; Type = "generic"; 
                Patterns = @("zoom_api_key.json", "video_conf_key.json", "zoom_credentials.json", "meeting_api.json")
                JSONTemplate = @{
                    "api_key" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                    "api_secret" = ""
                    "jwt_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9." + (-join ((1..100) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                }
            }
        )
        
        # Select random service and filename pattern
        $SelectedService = Get-Random -InputObject $APIServices
        $SelectedFilename = Get-Random -InputObject $SelectedService.Patterns
        
        # Generate API key based on service type
        $APIKey = Generate-RandomAPIKey -ServiceType $SelectedService.Type
        
        # Create JSON content based on service template
        $JSONData = $SelectedService.JSONTemplate.Clone()
        
        # Set the main API key field based on service
        switch ($SelectedService.Service) {
            "OpenAI" { $JSONData["api_key"] = $APIKey }
            "Stripe" { $JSONData["secret_key"] = $APIKey }
            "PayPal" { $JSONData["client_id"] = $APIKey }
            "AWS" { $JSONData["AccessKeyId"] = $APIKey }
            "Azure" { $JSONData["client_secret"] = $APIKey }
            "Square" { $JSONData["access_token"] = $APIKey }
            "Claude" { $JSONData["api_key"] = $APIKey }
            "Verkada" { $JSONData["api_key"] = $APIKey }
            "YouTube" { $JSONData["api_key"] = $APIKey }
            "Twilio" { $JSONData["auth_token"] = $APIKey }
            "Shopify" { $JSONData["password"] = $APIKey }
            "Discord" { $JSONData["bot_token"] = $APIKey }
            "Zoom" { $JSONData["api_secret"] = $APIKey }
            default { $JSONData["api_key"] = $APIKey }
        }
        
        # Convert to JSON with proper formatting
        $JSONContent = $JSONData | ConvertTo-Json -Depth 4
        
        # Save JSON file
        $FilePath = Join-Path -Path $DocumentsPath -ChildPath $SelectedFilename
        Set-Content -Path $FilePath -Value $JSONContent -Encoding UTF8
        
        Write-Host "  Created API key file: $SelectedFilename" -ForegroundColor Cyan
    }
    
    # Folders that should get default Windows icons
    $IconFolders = @("Desktop", "Documents", "Downloads", "Music", "Pictures", "Videos")
    
    # Check if the root path exists, create if it doesn't
    if (-not (Test-Path -Path $Path)) {
        try {
            New-Item -Path $Path -ItemType Directory -Force | Out-Null
            Write-Host "Created root directory: $Path" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to create root directory: $Path. Error: $_"
            return
        }
    }
    
    Write-Host "Creating $Count user folders in $Path..." -ForegroundColor Cyan
    
    $CreatedUsers = @()
    $FailedUsers = @()
    $ReportData = @()
    
    for ($i = 1; $i -le $Count; $i++) {
        # Generate random username
        $FirstInitial = Get-Random -InputObject $FirstInitials
        $LastName = Get-Random -InputObject $LastNames
        $Username = "$FirstInitial$($LastName.ToLower())"
        
        # Ensure unique username (add number if duplicate)
        $OriginalUsername = $Username
        $Counter = 1
        while ($CreatedUsers -contains $Username) {
            $Username = "$OriginalUsername$Counter"
            $Counter++
        }
        
        $UserPath = Join-Path -Path $Path -ChildPath $Username
        
        try {
            # Generate random password for this user
            $UserPassword = Generate-RandomPassword
            $UserReportItems = @()
            
            # Create main user folder
            if (-not (Test-Path -Path $UserPath)) {
                New-Item -Path $UserPath -ItemType Directory -Force | Out-Null
            }
            
            $UserReportItems += @{
                Type = "User Folder"
                Path = $UserPath
                Description = "Main user profile directory"
                Rationale = "Simulates a realistic Windows user profile structure for security testing and training scenarios"
            }
            
            # Create subfolders
            foreach ($SubFolder in $UserSubFolders) {
                $SubFolderPath = Join-Path -Path $UserPath -ChildPath $SubFolder
                New-Item -Path $SubFolderPath -ItemType Directory -Force | Out-Null
                
                $UserReportItems += @{
                    Type = "Subfolder"
                    Path = $SubFolderPath
                    Description = "$SubFolder folder with Windows 11 icon"
                    Rationale = "Standard Windows user profile subfolder structure for realistic environment simulation"
                }
                
                # Create login.txt file in Desktop folder
                if ($SubFolder -eq "Desktop") {
                    $CredentialFilename = Get-RandomCredentialFilename -Username $Username
                    $CredentialFilePath = Join-Path -Path $SubFolderPath -ChildPath $CredentialFilename
                    $LoginContent = @"
Username: $Username
Password: $UserPassword
"@
                    Set-Content -Path $CredentialFilePath -Value $LoginContent -Encoding UTF8
                    
                    $UserReportItems += @{
                        Type = "Credential File"
                        Path = $CredentialFilePath
                        Description = "Text file containing username and password ($CredentialFilename)"
                        Rationale = "Simulates common user behavior of saving credentials in easily accessible text files on the desktop for security awareness training"
                    }
                }
                
                # Create API key JSON file in Downloads folder
                if ($SubFolder -eq "Downloads") {
                    $APIDetails = Create-APIKeyFile -DocumentsPath $SubFolderPath -Username $Username
                    
                    $UserReportItems += @{
                        Type = "API Key File"
                        Path = $APIDetails.FilePath
                        Description = "JSON file containing API credentials for $($APIDetails.Service) ($($APIDetails.Filename))"
                        Rationale = "Represents realistic scenario where developers accidentally save sensitive API keys in Downloads folder, commonly found in security audits"
                    }
                }
                
                # Download random images to Pictures folder
                if ($SubFolder -eq "Pictures") {
                    $ImageDetails = Download-RandomImages -PicturesPath $SubFolderPath -Username $Username
                    
                    foreach ($ImageDetail in $ImageDetails) {
                        $UserReportItems += @{
                            Type = "Image File"
                            Path = $ImageDetail.Path
                            Description = "Downloaded image: $($ImageDetail.Name)"
                            Rationale = "Provides realistic content in Pictures folder to simulate actual user environments with diverse image collections"
                        }
                    }
                }
                
                # Set folder icons for specific folders (Windows 11)
                if ($IconFolders -contains $SubFolder) {
                    try {
                        # Create desktop.ini file to set folder icon
                        $DesktopIniPath = Join-Path -Path $SubFolderPath -ChildPath "desktop.ini"
                        $IconResource = switch ($SubFolder) {
                            "Desktop"   { "%SystemRoot%\System32\imageres.dll,-183" }
                            "Documents" { "%SystemRoot%\System32\imageres.dll,-112" }
                            "Downloads" { "%SystemRoot%\System32\imageres.dll,175" }
                            "Music"     { "%SystemRoot%\System32\imageres.dll,-108" }
                            "Pictures"  { "%SystemRoot%\System32\imageres.dll,-113" }
                            "Videos"    { "%SystemRoot%\System32\imageres.dll,-189" }
                        }
                        
                        $DesktopIniContent = @"
[.ShellClassInfo]
IconResource=$IconResource
[ViewState]
Mode=
Vid=
FolderType=Generic
"@
                        Set-Content -Path $DesktopIniPath -Value $DesktopIniContent -Force
                        
                        # Set desktop.ini as hidden and system file
                        (Get-Item $DesktopIniPath -Force).Attributes = 'Hidden,System'
                        
                        # Set folder as system folder to enable custom icon
                        (Get-Item $SubFolderPath -Force).Attributes = 'Directory,System'
                    }
                    catch {
                        Write-Warning "Could not set icon for $SubFolderPath`: $_"
                    }
                }
            }
            
            $CreatedUsers += $Username
            $ReportData += @{
                Username = $Username
                Password = $UserPassword
                Items = $UserReportItems
            }
            Write-Progress -Activity "Creating user folders" -Status "Created: $Username" -PercentComplete (($i / $Count) * 100)
        }
        catch {
            $FailedUsers += $Username
            Write-Warning "Failed to create user folder for '$Username': $_"
        }
    }
    
    # Summary
    Write-Host "`nOperation completed!" -ForegroundColor Green
    Write-Host "Successfully created: $($CreatedUsers.Count) user folders" -ForegroundColor Green
    
    if ($FailedUsers.Count -gt 0) {
        Write-Host "Failed to create: $($FailedUsers.Count) user folders" -ForegroundColor Red
        Write-Host "Failed users: $($FailedUsers -join ', ')" -ForegroundColor Red
    }
    
    Write-Host "`nSample created users:" -ForegroundColor Yellow
    $CreatedUsers | Select-Object -First 10 | ForEach-Object {
        Write-Host "  $_" -ForegroundColor White
    }
    
    if ($CreatedUsers.Count -gt 10) {
        Write-Host "  ... and $($CreatedUsers.Count - 10) more" -ForegroundColor Gray
    }
    
    # Generate HTML report if requested
    if ($Report) {
        $ScriptPath = if ($PSScriptRoot) { 
            $PSScriptRoot 
        } elseif ($MyInvocation.MyCommand.Path) { 
            Split-Path -Parent $MyInvocation.MyCommand.Path 
        } else { 
            $PWD.Path 
        }
        $ReportPath = Join-Path -Path $ScriptPath -ChildPath "Set-AmbushUsers_Report_$(Get-Date -Format 'yyyyMMdd_HHmmss').html"
        Generate-HTMLReport -ReportData $ReportData -ReportPath $ReportPath -TotalUsers $CreatedUsers.Count -FailedUsers $FailedUsers.Count
        Write-Host "`nHTML Report generated: $ReportPath" -ForegroundColor Green
    }
    }
    # Handle Decoy parameter
    if ($Decoy) {
        Write-Host "`n================================" -ForegroundColor Magenta
        Write-Host "CREATING DECOY STRUCTURE" -ForegroundColor Magenta
        Write-Host "================================" -ForegroundColor Magenta
        
        switch ($Decoy) {
            "Payroll" {
                # Determine the target directory
                # Use $Path if it exists and is a directory, otherwise attempt to create it; if creation fails, use current location
                if (Test-Path -Path $Path -PathType Container) {
                    $DecoyPath = $Path
                } else {
                    try {
                        New-Item -Path $Path -ItemType Directory -Force | Out-Null
                        Write-Host "Created path: $Path" -ForegroundColor Green
                        $DecoyPath = $Path
                    }
                    catch {
                        $DecoyPath = (Get-Location).Path
                        Write-Host "Path '$Path' could not be created. Using current location: $DecoyPath" -ForegroundColor Yellow
                    }
                }   

                New-PayrollDecoy -Path $DecoyPath
            }
        }
    }



}

# Function to generate HTML report
function Generate-HTMLReport {
    param(
        [array]$ReportData,
        [string]$ReportPath,
        [int]$TotalUsers,
        [int]$FailedUsers
    )
    
    $HTMLContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Set-AmbushUsers Report</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 2.5em;
            font-weight: 300;
        }
        .header h2 {
            margin: 10px 0 0 0;
            font-size: 1.2em;
            opacity: 0.9;
            font-weight: 400;
        }
        .summary {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .summary h3 {
            margin-top: 0;
            color: #4a5568;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 15px 0;
        }
        .stat-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            border-left: 4px solid #667eea;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            color: #666;
            font-size: 0.9em;
        }
        .user-section {
            background: white;
            margin: 20px 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .user-header {
            background: #4a5568;
            color: white;
            padding: 15px 20px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-password {
            background: rgba(255,255,255,0.2);
            padding: 5px 10px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
        }
        .items-table {
            width: 100%;
            border-collapse: collapse;
        }
        .items-table th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #e2e8f0;
            font-weight: 600;
            color: #4a5568;
        }
        .items-table td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: top;
        }
        .items-table tr:hover {
            background: #f8f9fa;
        }
        .type-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8em;
            font-weight: bold;
            text-transform: uppercase;
        }
        .type-folder { background: #e6fffa; color: #047857; }
        .type-credential { background: #fef2f2; color: #dc2626; }
        .type-api { background: #fff7ed; color: #ea580c; }
        .type-image { background: #f0f9ff; color: #0284c7; }
        .type-subfolder { background: #f5f3ff; color: #7c3aed; }
        .path {
            font-family: 'Courier New', monospace;
            background: #f1f5f9;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 0.85em;
            word-break: break-all;
        }
        .rationale {
            font-style: italic;
            color: #6b7280;
            font-size: 0.9em;
            line-height: 1.4;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            padding: 20px;
            color: #6b7280;
            border-top: 1px solid #e2e8f0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Guerilla Zero Trust Security</h1>
        <h2>Set-AmbushUsers Report</h2>
    </div>
    
    <div class="summary">
        <h3>Execution Summary</h3>
        <p>This report details the creation of simulated user environments designed for security testing, training, and Zero Trust validation scenarios.</p>
        
        <div class="stats">
            <div class="stat-box">
                <div class="stat-number">$TotalUsers</div>
                <div class="stat-label">Users Created</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">$FailedUsers</div>
                <div class="stat-label">Failed Creations</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">$(($ReportData | ForEach-Object { $_.Items } | Measure-Object).Count)</div>
                <div class="stat-label">Total Items Created</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</div>
                <div class="stat-label">Generated On</div>
            </div>
        </div>
    </div>
"@

    foreach ($User in $ReportData) {
        $HTMLContent += @"
    <div class="user-section">
        <div class="user-header">
            <span>$($User.Username)</span>
            <span class="user-password">Password: $($User.Password)</span>
        </div>
        <table class="items-table">
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Path</th>
                    <th>Description</th>
                    <th>Security Rationale</th>
                </tr>
            </thead>
            <tbody>
"@
        
        foreach ($Item in $User.Items) {
            $TypeClass = switch ($Item.Type) {
                "User Folder" { "type-folder" }
                "Credential File" { "type-credential" }
                "API Key File" { "type-api" }
                "Image File" { "type-image" }
                "Subfolder" { "type-subfolder" }
                default { "type-folder" }
            }
            
            $HTMLContent += @"
                <tr>
                    <td><span class="type-badge $TypeClass">$($Item.Type)</span></td>
                    <td><code class="path">$($Item.Path)</code></td>
                    <td>$($Item.Description)</td>
                    <td><div class="rationale">$($Item.Rationale)</div></td>
                </tr>
"@
        }
        
        $HTMLContent += @"
            </tbody>
        </table>
    </div>
"@
    }
    
    $HTMLContent += @"
    <div class="footer">
        <p><strong>Guerilla Zero Trust Security</strong> | Set-AmbushUsers v1.0</p>
        <p>Generated for security testing and training purposes. All simulated data is for authorized security assessments only.</p>
    </div>
</body>
</html>
"@

    Set-Content -Path $ReportPath -Value $HTMLContent -Encoding UTF8
}


#Set-AmbushUsers -Path "C:\Users\Jim\Downloads\Users" -count 5 -Report

# Export all functions implemented in this module
Export-ModuleMember -Function `
    New-PayrollDecoy, `
    Create-APIKeyFile, `
    Download-RandomImages, `
    Set-Ambush, `
    Generate-HTMLReport, `
    Generate-RandomPassword, `
    Get-RandomCredentialFilename, `
    Generate-RandomAPIKey