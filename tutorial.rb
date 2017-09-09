require 'thread'
require 'nokogiri'         
require 'open-uri'

def analysis(stocks)
  map = {}

  stocks.each do |stock|
    page = Nokogiri::HTML(open("http://www.google.com/finance?q=#{stock}"))
    sector_content = page.search('#sector')

    industry = sector_content.children[0].content if sector_content && sector_content.children[0]

    next unless industry
    map[industry] ||= []
    map[industry] << stock
  end

  map.sort_by{ |k,v| -v.length }
end

def run_multiple(stocks)
  work_q = Queue.new
  stocks.each{ |stock| work_q.push stock }
  map = {}
  workers = (0...10).map do
    Thread.new do
      begin
        while stock = work_q.pop(true)
          industry = task(stock)
          map[industry] ||= []
          map[industry] << stock unless map[industry].include?(stock)
        end
      rescue ThreadError
      end
    end
  end; "ok"
  workers.map(&:join); "ok"

  map.sort_by{ |k,v| -v.length }
end


def task(stock)
  page = Nokogiri::HTML(open("http://www.google.com/finance?q=#{stock}"))
  sector_content = page.search('#sector')

  industry = sector_content.children[0].content if sector_content && sector_content.children[0]

  industry
end



# puts 'last year'

# puts "miracle stocks"
# stocks = ['CRBP', 'EGLE', 'PTCT', 'HOS', 'PACD', 'ORIG', 'TDW', 'PTI', 'CXW', 'NIHD', 'ENPH', 'NOG', 'CRR', 'ATT', 'INAP', 'SPPI', 'IMGN', 'LX', 'TGTX', 'BANC', 'XENT', 'MNKD', 'PLG', 'COGT', 'AGFS', 'HNR', 'IDRA', 'ANGI', 'QTNT', 'ALNY', 'VHC', 'FOLD', 'PBYI', 'CYTR', 'SVRA', 'AMRS', 'XCO', 'VEC', 'CIE', 'ABEO', 'SITO', 'FTR', 'DRRX', 'DVAX']
# puts analysis(stocks).inspect


# puts "shitty stocks"
# stocks = ['MRTX', 'KNDI', 'TLRD', 'ZMZ', 'DNR', 'EXK', 'OAS', 'TIS', 'CGEN', 'AGEN', 'CCO', 'SIG', 'ASCM_A', 'MGNX', 'ERII', 'FNBC', 'VSTO', 'WLB', 'EPE', 'GPRO', 'CTRV', 'GST', 'RT', 'RELY', 'SNA', 'TRXC', 'LBY', 'DEPO', 'OVAS', 'AMSC', 'ALDR', 'AOI', 'APEN', 'NM', 'AFSI', 'AOS', 'RAS', 'SPN', 'AA', 'RIG', 'PIR', 'ATHX', 'IVTY', 'VRTV', 'ENDP', 'CLNE', 'NAVB', 'CHD', 'RBN', 'NAVG', 'FFWM', 'FRAN', 'HZN', 'CETX', 'MX', 'LTRP_A', 'P', 'SRPT', 'XBIT', 'X', 'NPTN', 'BCOV', 'TPX', 'INSY', 'SNAK', 'NVIV', 'BWEN', 'BVX', 'SFS', 'HIVE', 'CEMP', 'WKHS', 'FLDM', 'VNCE', 'OSG', 'PACB', 'ITEK', 'AGTC', 'WLL', 'TA', 'MTRX', 'PMTS', 'ACTG', 'AMAG', 'DPLO', 'SHLO', 'OCN', 'BRS', 'ARGS', 'HZNP', 'EYES', 'SYN', 'TES', 'CRC', 'COLL', 'CRMD', 'HTBX', 'GPOR', 'PFNX', 'CHKE', 'SLCA', 'GIII', 'DRYS', 'EROS', 'ZYNE', 'PTN', 'DTEA', 'GV', 'ECYT', 'OCL', 'CHRS', 'AMC', 'BMI', 'CKH', 'TCS']
# puts analysis(stocks).inspect


puts '2015/07-2017/08'

puts "miracle stocks"
stocks = ['CRK', 'BTU', 'EXXI', 'CALA', 'LOCK', 'BLT', 'SCTY', 'RWLK', 'TIVO', 'ADMS', 'HK', 'TRXC', 'VHC', 'IO', 'GRPN', 'ANFI', 'ZEUS', 'DRYS', 'WATT', 'CDE', 'SWC', 'MCF', 'QUOT', 'GALE', 'CLF', 'BBG', 'CRMD', 'DDD', 'X', 'GORO', 'LAYN', 'RGLD', 'CLR', 'SLCA', 'AOI', 'SN', 'APIC', 'RYI', 'WG', 'NOG', 'HEES', 'HMSY', 'RRC', 'ARCO', 'RYAM', 'OKE', 'LPI', 'RIGP', 'IMMU', 'QUAD', 'CZZ', 'UNIS', 'CORR', 'GSAT', 'EZPW', 'ININ', 'XNPT', 'HOMB', 'PAYC', 'FET', 'RICE', 'PACD', 'SUPN', 'MKTO', 'DWRE', 'AMBR', 'FBP', 'KEYW', 'ARIA', 'CRC', 'OLN', 'SPN', 'WPX', 'FMSA', 'GEOS', 'WYNN', 'XBIT', 'BOOM', 'AXLL', 'NEFF', 'RDEN', 'SBLK', 'NYMX', 'ONVO', 'HRI', 'TSRO', 'GNMK', 'NTK', 'VMEM', 'S', 'ELGX', 'PFPT', 'AVXL', 'BNFT', 'LRN', 'SSTK', 'SGY', 'EVH', 'TRNC', 'OFG',
'BTU', 'EXXI', 'CALA', 'LOCK', 'BLT', 'SCTY', 'RWLK', 'TIVO', 'ADMS', 'HK', 'TRXC', 'VHC', 'IO', 'GRPN', 'ANFI', 'ZEUS', 'DRYS', 'WATT', 'CDE', 'SWC', 'MCF', 'QUOT', 'GALE', 'CLF', 'BBG', 'CRMD', 'DDD', 'X', 'GORO', 'LAYN', 'RGLD', 'CLR', 'SLCA', 'AOI', 'SN', 'APIC', 'RYI', 'WG', 'NOG', 'HEES', 'HMSY', 'RRC', 'ARCO', 'RYAM', 'OKE', 'LPI', 'RIGP', 'IMMU', 'QUAD', 'CZZ', 'UNIS', 'CORR', 'GSAT', 'EZPW', 'ININ', 'XNPT', 'HOMB', 'PAYC', 'FET', 'RICE', 'PACD', 'SUPN', 'MKTO', 'DWRE', 'AMBR', 'FBP', 'KEYW', 'ARIA', 'CRC', 'OLN', 'SPN', 'WPX', 'FMSA', 'GEOS', 'WYNN', 'XBIT', 'BOOM', 'AXLL', 'NEFF', 'RDEN', 'SBLK', 'NYMX', 'ONVO', 'HRI', 'TSRO', 'GNMK', 'NTK', 'VMEM', 'S', 'ELGX', 'PFPT', 'AVXL', 'BNFT', 'LRN', 'SSTK', 'SGY', 'EVH', 'TRNC', 'OFG', 'BDC',
'EXXI', 'CALA', 'LOCK', 'BLT', 'SCTY', 'RWLK', 'TIVO', 'ADMS', 'HK', 'TRXC', 'VHC', 'IO', 'GRPN', 'ANFI', 'ZEUS', 'DRYS', 'WATT', 'CDE', 'SWC', 'MCF', 'QUOT', 'GALE', 'CLF', 'BBG', 'CRMD', 'DDD', 'X', 'GORO', 'LAYN', 'RGLD', 'CLR', 'SLCA', 'AOI', 'SN', 'APIC', 'RYI', 'WG', 'NOG', 'HEES', 'HMSY', 'RRC', 'ARCO', 'RYAM', 'OKE', 'LPI', 'RIGP', 'IMMU', 'QUAD', 'CZZ', 'UNIS', 'CORR', 'GSAT', 'EZPW', 'ININ', 'XNPT', 'HOMB', 'PAYC', 'FET', 'RICE', 'PACD', 'SUPN', 'MKTO', 'DWRE', 'AMBR', 'FBP', 'KEYW', 'ARIA', 'CRC', 'OLN', 'SPN', 'WPX', 'FMSA', 'GEOS', 'WYNN', 'XBIT', 'BOOM', 'AXLL', 'NEFF', 'RDEN', 'SBLK', 'NYMX', 'ONVO', 'HRI', 'TSRO', 'GNMK', 'NTK', 'VMEM', 'S', 'ELGX', 'PFPT', 'AVXL', 'BNFT', 'LRN', 'SSTK', 'SGY', 'EVH', 'TRNC', 'OFG', 'BDC', 'XRM',
'CALA', 'LOCK', 'BLT', 'SCTY', 'RWLK', 'TIVO', 'ADMS', 'HK', 'TRXC', 'VHC', 'IO', 'GRPN', 'ANFI', 'ZEUS', 'DRYS', 'WATT', 'CDE', 'SWC', 'MCF', 'QUOT', 'GALE', 'CLF', 'BBG', 'CRMD', 'DDD', 'X', 'GORO', 'LAYN', 'RGLD', 'CLR', 'SLCA', 'AOI', 'SN', 'APIC', 'RYI', 'WG', 'NOG', 'HEES', 'HMSY', 'RRC', 'ARCO', 'RYAM', 'OKE', 'LPI', 'RIGP', 'IMMU', 'QUAD', 'CZZ', 'UNIS', 'CORR', 'GSAT', 'EZPW', 'ININ', 'XNPT', 'HOMB', 'PAYC', 'FET', 'RICE', 'PACD', 'SUPN', 'MKTO', 'DWRE', 'AMBR', 'FBP', 'KEYW', 'ARIA', 'CRC', 'OLN', 'SPN', 'WPX', 'FMSA', 'GEOS', 'WYNN', 'XBIT', 'BOOM', 'AXLL', 'NEFF', 'RDEN', 'SBLK', 'NYMX', 'ONVO', 'HRI', 'TSRO', 'GNMK', 'NTK', 'VMEM', 'S', 'ELGX', 'PFPT', 'AVXL', 'BNFT', 'LRN', 'SSTK', 'SGY', 'EVH', 'TRNC', 'OFG', 'BDC', 'XRM', 'LKFN']


#puts analysis(stocks).inspect
puts run_multiple(stocks).inspect


puts "shitty stocks"
stocks = ['LIFE', 'EKSO', 'EVHC', 'WLL', 'RTK', 'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC',
 'EKSO', 'EVHC', 'WLL', 'RTK', 'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT',
 'EVHC', 'WLL', 'RTK', 'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN',
 'WLL', 'RTK', 'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN', 'OHGI',
'RTK', 'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN', 'OHGI', 'LTS',
'JWN', 'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN', 'OHGI', 'LTS', 'CNCE',
'ERII', 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN', 'OHGI', 'LTS', 'CNCE', 'LJPC',
 'ESPR', 'ACET', 'SSYS', 'XON', 'RPTP', 'INVN', 'RLGT', 'TAX', 'ALDR', 'BWA', 'HIFR', 'TAL', 'VRTU', 'VRTV', 'VOYA', 'CSIQ', 'ENDP', 'GLPW', 'RJET', 'HZN', 'ENTL', 'MNKD', 'P', 'RDWR', 'MXPT', 'CHRS', 'NE', 'GI', 'OTIC', 'NVIV', 'LNCO', 'HDP', 'HIVE', 'WKHS', 'OSG', 'LAZ', 'SIG', 'FCEL', 'INVA', 'MGNX', 'CMG', 'CSWC', 'UPL', 'CHKR', 'TPLM', 'SEAC', 'CHKE', 'VCEL', 'LNKD', 'SZMK', 'TANH', 'APOL', 'MBOT', 'DVAX', 'TTI', 'AROC', 'NVUS', 'TTC', 'SHAK', 'FSLR', 'UVE', 'DSX', 'MRIN', 'DSW', 'DST', 'ZG', 'JAKK', 'BLL', 'BBOX', 'CPRX', 'FTK', 'CPRT', 'MTEM', 'RLGY', 'ITGR', 'CBK', 'CBI', 'LNT', 'CBL', 'CBR', 'INO', 'ASNA', 'CROX', 'EVLV', 'AKS', 'HAIN', 'ABTL', 'GLF', 'HURN', 'RAVE', 'FI', 'ORIG', 'VSEC', 'BONT', 'MDVN', 'OHGI', 'LTS', 'CNCE', 'LJPC', 'HABT']
#puts analysis(stocks).inspect
puts run_multiple(stocks).inspect
