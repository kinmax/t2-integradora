require 'json'
require 'byebug'

file_path = File.join(File.dirname(__FILE__), 'results_uniqueness.json')
file = File.open(file_path, 'r')
raw = file.read
results = JSON.parse(raw)
output_path = "/home/kingusmao/tcc/table.txt"

table = "\\begin{table}[h]
\\centering
\\resizebox{\\textwidth}{!}{%
    \\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}
      \\hline
      \\multicolumn{4}{|c|}{}&\\multicolumn{4}{|c|}{\\textit{Exhaust}}&\\multicolumn{4}{|c|}{\\textit{h^m}}&\\multicolumn{4}{|c|}{\\textit{RHW}}&\\multicolumn{4}{|c|}{\\textit{Zhu/Givan}}\\\\
      \\hline
      \\textbf{Domain}&$|\\mathcal{G}|$&\\textbf{\\% Obs}&$|\\mathcal{O}|$&$|\\mathcal{L}|$&\\makecell{\\textbf{Time (s)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Accuracy (\\%)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Spread}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&$|\\mathcal{L}|$&\\makecell{\\textbf{Time (s)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 /30)}}&\\makecell{\\textbf{Accuracy (\\%)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Spread}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{$|\\mathcal{L}|$}&\\makecell{\\textbf{Time (s)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Accuracy (\\%)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Spread}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{$|\\mathcal{L}|$}&\\makecell{\\textbf{Time (s)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 /30)}}&\\makecell{\\textbf{Accuracy (\\%)}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}&\\makecell{\\textbf{Spread}\\\\$\\theta$   \\textbf{(0 / 10 / 20 / 30)}}\\\\
      \\hline
      "

results.each do |key, value|
    domain = key.upcase
    table += "\\makecell{#{domain}\\\\#{value["problems"]}} & #{'%.1f' % value["goals_avg"]} & \\makecell{10 \\\\ 30 \\\\ 50 \\\\ 70 \\\\ 100} & \\makecell{#{'%.1f' % value["observations"]["10"]["observations_avg"]} \\\\ #{'%.1f' % value["observations"]["30"]["observations_avg"]} \\\\ #{'%.1f' % value["observations"]["50"]["observations_avg"]} \\\\ #{'%.1f' % value["observations"]["70"]["observations_avg"]} \\\\ #{'%.1f' % value["observations"]["100"]["observations_avg"]}} & #{'%.1f' % value["landmarks_avg"]["exhaust"]} & \\makecell{#{'%.3f' % value["observations"]["10"]["exhaust"]["time"]["0"]} / #{'%.3f' % value["observations"]["10"]["exhaust"]["time"]["10"]} / #{'%.3f' % value["observations"]["10"]["exhaust"]["time"]["20"]} / #{'%.3f' % value["observations"]["10"]["exhaust"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["30"]["exhaust"]["time"]["0"]} / #{'%.3f' % value["observations"]["30"]["exhaust"]["time"]["10"]} / #{'%.3f' % value["observations"]["30"]["exhaust"]["time"]["20"]} / #{'%.3f' % value["observations"]["30"]["exhaust"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["50"]["exhaust"]["time"]["0"]} / #{'%.3f' % value["observations"]["50"]["exhaust"]["time"]["10"]} / #{'%.3f' % value["observations"]["50"]["exhaust"]["time"]["20"]} / #{'%.3f' % value["observations"]["50"]["exhaust"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["70"]["exhaust"]["time"]["0"]} / #{'%.3f' % value["observations"]["70"]["exhaust"]["time"]["10"]} / #{'%.3f' % value["observations"]["70"]["exhaust"]["time"]["20"]} / #{'%.3f' % value["observations"]["70"]["exhaust"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["100"]["exhaust"]["time"]["0"]} / #{'%.3f' % value["observations"]["100"]["exhaust"]["time"]["10"]} / #{'%.3f' % value["observations"]["100"]["exhaust"]["time"]["20"]} / #{'%.3f' % value["observations"]["100"]["exhaust"]["time"]["30"]}} & \\makecell{#{'%.1f' % value["observations"]["10"]["exhaust"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["10"]["exhaust"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["10"]["exhaust"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["10"]["exhaust"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["30"]["exhaust"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["30"]["exhaust"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["30"]["exhaust"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["30"]["exhaust"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["50"]["exhaust"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["50"]["exhaust"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["50"]["exhaust"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["50"]["exhaust"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["70"]["exhaust"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["70"]["exhaust"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["70"]["exhaust"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["70"]["exhaust"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["100"]["exhaust"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["100"]["exhaust"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["100"]["exhaust"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["100"]["exhaust"]["accuracy"]["30"]}} & \\makecell{#{"%.3f" % value["spread"]["10"]["exhaust"]["0"]} / #{"%.3f" % value["spread"]["10"]["exhaust"]["10"]} / #{"%.3f" % value["spread"]["10"]["exhaust"]["20"]} / #{"%.3f" % value["spread"]["10"]["exhaust"]["30"]} \\\\ #{"%.3f" % value["spread"]["30"]["exhaust"]["0"]} / #{"%.3f" % value["spread"]["30"]["exhaust"]["10"]} / #{"%.3f" % value["spread"]["30"]["exhaust"]["20"]} / #{"%.3f" % value["spread"]["30"]["exhaust"]["30"]} \\\\ #{"%.3f" % value["spread"]["50"]["exhaust"]["0"]} / #{"%.3f" % value["spread"]["50"]["exhaust"]["10"]} / #{"%.3f" % value["spread"]["50"]["exhaust"]["20"]} / #{"%.3f" % value["spread"]["50"]["exhaust"]["30"]} \\\\ #{"%.3f" % value["spread"]["70"]["exhaust"]["0"]} / #{"%.3f" % value["spread"]["70"]["exhaust"]["10"]} / #{"%.3f" % value["spread"]["70"]["exhaust"]["20"]} / #{"%.3f" % value["spread"]["70"]["exhaust"]["30"]} \\\\ #{"%.3f" % value["spread"]["100"]["exhaust"]["0"]} / #{"%.3f" % value["spread"]["100"]["exhaust"]["10"]} / #{"%.3f" % value["spread"]["100"]["exhaust"]["20"]} / #{"%.3f" % value["spread"]["100"]["exhaust"]["30"]}} & #{'%.1f' % value["landmarks_avg"]["hm"]} & \\makecell{#{'%.3f' % value["observations"]["10"]["hm"]["time"]["0"]} / #{'%.3f' % value["observations"]["10"]["hm"]["time"]["10"]} / #{'%.3f' % value["observations"]["10"]["hm"]["time"]["20"]} / #{'%.3f' % value["observations"]["10"]["hm"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["30"]["hm"]["time"]["0"]} / #{'%.3f' % value["observations"]["30"]["hm"]["time"]["10"]} / #{'%.3f' % value["observations"]["30"]["hm"]["time"]["20"]} / #{'%.3f' % value["observations"]["30"]["hm"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["50"]["hm"]["time"]["0"]} / #{'%.3f' % value["observations"]["50"]["hm"]["time"]["10"]} / #{'%.3f' % value["observations"]["50"]["hm"]["time"]["20"]} / #{'%.3f' % value["observations"]["50"]["hm"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["70"]["hm"]["time"]["0"]} / #{'%.3f' % value["observations"]["70"]["hm"]["time"]["10"]} / #{'%.3f' % value["observations"]["70"]["hm"]["time"]["20"]} / #{'%.3f' % value["observations"]["70"]["hm"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["100"]["hm"]["time"]["0"]} / #{'%.3f' % value["observations"]["100"]["hm"]["time"]["10"]} / #{'%.3f' % value["observations"]["100"]["hm"]["time"]["20"]} / #{'%.3f' % value["observations"]["100"]["hm"]["time"]["30"]}} & \\makecell{#{'%.1f' % value["observations"]["10"]["hm"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["10"]["hm"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["10"]["hm"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["10"]["hm"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["30"]["hm"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["30"]["hm"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["30"]["hm"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["30"]["hm"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["50"]["hm"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["50"]["hm"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["50"]["hm"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["50"]["hm"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["70"]["hm"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["70"]["hm"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["70"]["hm"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["70"]["hm"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["100"]["hm"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["100"]["hm"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["100"]["hm"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["100"]["hm"]["accuracy"]["30"]}} & \\makecell{#{"%.3f" % value["spread"]["10"]["hm"]["0"]} / #{"%.3f" % value["spread"]["10"]["hm"]["10"]} / #{"%.3f" % value["spread"]["10"]["hm"]["20"]} / #{"%.3f" % value["spread"]["10"]["hm"]["30"]} \\\\ #{"%.3f" % value["spread"]["30"]["hm"]["0"]} / #{"%.3f" % value["spread"]["30"]["hm"]["10"]} / #{"%.3f" % value["spread"]["30"]["hm"]["20"]} / #{"%.3f" % value["spread"]["30"]["hm"]["30"]} \\\\ #{"%.3f" % value["spread"]["50"]["hm"]["0"]} / #{"%.3f" % value["spread"]["50"]["hm"]["10"]} / #{"%.3f" % value["spread"]["50"]["hm"]["20"]} / #{"%.3f" % value["spread"]["50"]["hm"]["30"]} \\\\ #{"%.3f" % value["spread"]["70"]["hm"]["0"]} / #{"%.3f" % value["spread"]["70"]["hm"]["10"]} / #{"%.3f" % value["spread"]["70"]["hm"]["20"]} / #{"%.3f" % value["spread"]["70"]["hm"]["30"]} \\\\ #{"%.3f" % value["spread"]["100"]["hm"]["0"]} / #{"%.3f" % value["spread"]["100"]["hm"]["10"]} / #{"%.3f" % value["spread"]["100"]["hm"]["20"]} / #{"%.3f" % value["spread"]["100"]["hm"]["30"]}} & #{'%.1f' % value["landmarks_avg"]["rhw"]} & \\makecell{#{'%.3f' % value["observations"]["10"]["rhw"]["time"]["0"]} / #{'%.3f' % value["observations"]["10"]["rhw"]["time"]["10"]} / #{'%.3f' % value["observations"]["10"]["rhw"]["time"]["20"]} / #{'%.3f' % value["observations"]["10"]["rhw"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["30"]["rhw"]["time"]["0"]} / #{'%.3f' % value["observations"]["30"]["rhw"]["time"]["10"]} / #{'%.3f' % value["observations"]["30"]["rhw"]["time"]["20"]} / #{'%.3f' % value["observations"]["30"]["rhw"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["50"]["rhw"]["time"]["0"]} / #{'%.3f' % value["observations"]["50"]["rhw"]["time"]["10"]} / #{'%.3f' % value["observations"]["50"]["rhw"]["time"]["20"]} / #{'%.3f' % value["observations"]["50"]["rhw"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["70"]["rhw"]["time"]["0"]} / #{'%.3f' % value["observations"]["70"]["rhw"]["time"]["10"]} / #{'%.3f' % value["observations"]["70"]["rhw"]["time"]["20"]} / #{'%.3f' % value["observations"]["70"]["rhw"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["100"]["rhw"]["time"]["0"]} / #{'%.3f' % value["observations"]["100"]["rhw"]["time"]["10"]} / #{'%.3f' % value["observations"]["100"]["rhw"]["time"]["20"]} / #{'%.3f' % value["observations"]["100"]["rhw"]["time"]["30"]}} & \\makecell{#{'%.1f' % value["observations"]["10"]["rhw"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["10"]["rhw"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["10"]["rhw"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["10"]["rhw"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["30"]["rhw"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["30"]["rhw"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["30"]["rhw"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["30"]["rhw"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["50"]["rhw"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["50"]["rhw"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["50"]["rhw"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["50"]["rhw"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["70"]["rhw"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["70"]["rhw"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["70"]["rhw"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["70"]["rhw"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["100"]["rhw"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["100"]["rhw"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["100"]["rhw"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["100"]["rhw"]["accuracy"]["30"]}} & \\makecell{#{"%.3f" % value["spread"]["10"]["rhw"]["0"]} / #{"%.3f" % value["spread"]["10"]["rhw"]["10"]} / #{"%.3f" % value["spread"]["10"]["rhw"]["20"]} / #{"%.3f" % value["spread"]["10"]["rhw"]["30"]} \\\\ #{"%.3f" % value["spread"]["30"]["rhw"]["0"]} / #{"%.3f" % value["spread"]["30"]["rhw"]["10"]} / #{"%.3f" % value["spread"]["30"]["rhw"]["20"]} / #{"%.3f" % value["spread"]["30"]["rhw"]["30"]} \\\\ #{"%.3f" % value["spread"]["50"]["rhw"]["0"]} / #{"%.3f" % value["spread"]["50"]["rhw"]["10"]} / #{"%.3f" % value["spread"]["50"]["rhw"]["20"]} / #{"%.3f" % value["spread"]["50"]["rhw"]["30"]} \\\\ #{"%.3f" % value["spread"]["70"]["rhw"]["0"]} / #{"%.3f" % value["spread"]["70"]["rhw"]["10"]} / #{"%.3f" % value["spread"]["70"]["rhw"]["20"]} / #{"%.3f" % value["spread"]["70"]["rhw"]["30"]} \\\\ #{"%.3f" % value["spread"]["100"]["rhw"]["0"]} / #{"%.3f" % value["spread"]["100"]["rhw"]["10"]} / #{"%.3f" % value["spread"]["100"]["rhw"]["20"]} / #{"%.3f" % value["spread"]["100"]["rhw"]["30"]}} & #{'%.1f' % value["landmarks_avg"]["zg"]} & \\makecell{#{'%.3f' % value["observations"]["10"]["zg"]["time"]["0"]} / #{'%.3f' % value["observations"]["10"]["zg"]["time"]["10"]} / #{'%.3f' % value["observations"]["10"]["zg"]["time"]["20"]} / #{'%.3f' % value["observations"]["10"]["zg"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["30"]["zg"]["time"]["0"]} / #{'%.3f' % value["observations"]["30"]["zg"]["time"]["10"]} / #{'%.3f' % value["observations"]["30"]["zg"]["time"]["20"]} / #{'%.3f' % value["observations"]["30"]["zg"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["50"]["zg"]["time"]["0"]} / #{'%.3f' % value["observations"]["50"]["zg"]["time"]["10"]} / #{'%.3f' % value["observations"]["50"]["zg"]["time"]["20"]} / #{'%.3f' % value["observations"]["50"]["zg"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["70"]["zg"]["time"]["0"]} / #{'%.3f' % value["observations"]["70"]["zg"]["time"]["10"]} / #{'%.3f' % value["observations"]["70"]["zg"]["time"]["20"]} / #{'%.3f' % value["observations"]["70"]["zg"]["time"]["30"]} \\\\ #{'%.3f' % value["observations"]["100"]["zg"]["time"]["0"]} / #{'%.3f' % value["observations"]["100"]["zg"]["time"]["10"]} / #{'%.3f' % value["observations"]["100"]["zg"]["time"]["20"]} / 
    #{'%.3f' % value["observations"]["100"]["zg"]["time"]["30"]}} & \\makecell{#{'%.1f' % value["observations"]["10"]["zg"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["10"]["zg"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["10"]["zg"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["10"]["zg"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["30"]["zg"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["30"]["zg"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["30"]["zg"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["30"]["zg"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["50"]["zg"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["50"]["zg"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["50"]["zg"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["50"]["zg"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["70"]["zg"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["70"]["zg"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["70"]["zg"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["70"]["zg"]["accuracy"]["30"]} \\\\ #{'%.1f' % value["observations"]["100"]["zg"]["accuracy"]["0"]} / #{'%.1f' % value["observations"]["100"]["zg"]["accuracy"]["10"]} / #{'%.1f' % value["observations"]["100"]["zg"]["accuracy"]["20"]} / #{'%.1f' % value["observations"]["100"]["zg"]["accuracy"]["30"]}} & \\makecell{#{"%.3f" % value["spread"]["10"]["zg"]["0"]} / #{"%.3f" % value["spread"]["10"]["zg"]["10"]} / #{"%.3f" % value["spread"]["10"]["zg"]["20"]} / #{"%.3f" % value["spread"]["10"]["zg"]["30"]} \\\\ #{"%.3f" % value["spread"]["30"]["zg"]["0"]} / #{"%.3f" % value["spread"]["30"]["zg"]["10"]} / #{"%.3f" % value["spread"]["30"]["zg"]["20"]} / #{"%.3f" % value["spread"]["30"]["zg"]["30"]} \\\\ #{"%.3f" % value["spread"]["50"]["zg"]["0"]} / #{"%.3f" % value["spread"]["50"]["zg"]["10"]} / #{"%.3f" % value["spread"]["50"]["zg"]["20"]} / #{"%.3f" % value["spread"]["50"]["zg"]["30"]} \\\\ #{"%.3f" % value["spread"]["70"]["zg"]["0"]} / #{"%.3f" % value["spread"]["70"]["zg"]["10"]} / #{"%.3f" % value["spread"]["70"]["zg"]["20"]} / #{"%.3f" % value["spread"]["70"]["zg"]["30"]} \\\\ #{"%.3f" % value["spread"]["100"]["zg"]["0"]} / #{"%.3f" % value["spread"]["100"]["zg"]["10"]} / #{"%.3f" % value["spread"]["100"]["zg"]["20"]} / #{"%.3f" % value["spread"]["100"]["zg"]["30"]}} \\Bstrut \\\\
    \\hline
    "
end

table += "\\end{tabular}}
\\caption{Resultados obtidos na reprodução dos experimentos}
\\label{table:resultados}
\\end{table}"

File.write(output_path, table)

