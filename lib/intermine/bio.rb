require "net/http"

module InterMine
    module Bio
        VERSION = "0.98.1"
    end

    module Results

        class ResultsReader

            RESOURCE_PATH = "/check/"

            def each_gff3
                adjust_path(:gff3)
                each_line(params("gff3")) do |line|
                    yield line
                end
            end

            def each_fasta
                adjust_path(:fasta)
                each_line(params("fasta")) do |line|
                    yield line
                end
            end

            def each_bed
                adjust_path(:bed)
                each_line(params("bed")) do |line|
                    yield line
                end
            end

            def adjust_path(variant)
                @resources ||= {}
                root = @query.service.root
                uri = URI.parse(root + RESOURCE_PATH + "query." + variant.to_s)
                p uri
                @resources[variant] = Net::HTTP.get(uri.host, uri.path)
                path = @resources[variant]
                @uri = URI.parse(root + path)
            end

        end
    end
end

