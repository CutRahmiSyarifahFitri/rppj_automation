# The `App` class serves as a container for page objects
# It provides memoized access to these objects to ensure each
# page object is only instantiated once per instance of the `App` class.
class App
  p 'call app.rb'
  def login_page
    @login_page ||= LoginPage.new
  end

  def dashboard_page
    @dashboard_page ||= DashboardPage.new
  end

  def pencarian_page
    @pencarian_page ||= PencarianPage.new
  end

  def status_laporan_list_page
    @status_laporan_list_page ||= StatusLaporanListPage.new
  end

  def konfirmasi_laporan_page
    @konfirmasi_laporan_page ||= KonfirmasiLaporanPage.new
  end

  def CheckPoint
    @CheckPoint ||= CheckPoint.new
  end

  def crud_simpang_bayah_lane_page
    @crud_simpang_bayah_lane_page ||= CrudSimpangBayahLanePage.new
  end

  def responsesaver
    @responsesaver ||= ResponseSaver.new
  end

  def login_page_fam
    @login_page_fam ||= LoginPageFam.new
  end
  
  def dumping_selesai
    @dumping_selesai ||= DumpingSelesai.new
  end
   
end
