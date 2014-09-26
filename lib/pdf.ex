defmodule PDF do
    # return file name of generated pdf
    # requires: Porcelain, Random
    def generate( html ) do
        alias Porcelain.Result
        program = System.find_executable("wkhtmltopdf")
        html_file = Path.join System.tmp_dir, Random.string <> ".html"
        File.write html_file, html
        pdf_file  = Path.join System.tmp_dir, Random.string <> ".pdf"
        %Result{out: output, status: status} = Porcelain.exec(
            program, [ html_file, pdf_file ]
        )
        pdf_file
    end
end
