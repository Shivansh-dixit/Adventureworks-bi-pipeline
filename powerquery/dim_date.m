let
    Source = Csv.Document(
        File.Contents("C:\Users\LENOVO\Downloads\Adventure_works_CSV\AdventureWorks_Calendar.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.None]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    TypedDate = Table.TransformColumnTypes(Headers,{{"Date", type date}}),
    AddYear = Table.AddColumn(TypedDate, "Year", each Date.Year([Date]), Int64.Type),
    AddMonth = Table.AddColumn(AddYear, "MonthNum", each Date.Month([Date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonth, "MonthName", each Date.ToText([Date], "MMM"), type text),
    AddQuarter = Table.AddColumn(AddMonthName, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    AddYearMonth = Table.AddColumn(AddQuarter, "YearMonth", each Text.From(Date.Year([Date])) & "-" & Text.PadStart(Text.From(Date.Month([Date])),2,"0"), type text)
in
    AddYearMonth
