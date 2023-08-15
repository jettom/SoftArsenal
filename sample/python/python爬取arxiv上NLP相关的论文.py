# python爬取arxiv上NLP相关的论文
'''
pip install arxiv
pip install beautifulsoap4
pip install requests
'''
# 确定爬取的论文关键词

# 利用arxiv包，以Natural Language Processing为关键词，提交时间作为排序条件，获取最近提交的NLP领域最新的20篇论文。
arxiv_search = arxiv.Search(
query = "Natural Language Processing",
max_results = 20,
sort_by=arxiv.SortCriterion.SubmittedDate
)

# 获取论文的基础信息

# 通过代码获取论文的ID、标题、摘要、第一作者、发布时间、更新时间等信息。
for result in arxiv_search.results():
    paper_id = result.get_short_id() # 文章id
    paper_title = result.title # 文章标题
    paper_url = result.entry_id # 文章url
    paper_summary = result.summary.replace("\n", "") # 文章摘要需要剔除格式
    paper_first_author = result.authors[0] # 文章的第一作者
    publish_time = result.published.date() # 文章的发布时间
    update_time = result.updated.date() # 文章的更新时间

# 获取论文的代码地址和github上stars

# 根据论文的id获取代码链接，并通过解析github链接获取代码仓库的stars数量，评估项目热度。

# 根据paper_id获取github代码链接
def get_paper_code_url(paper_id):
    base_url = "https://arxiv.paperswithcode.com/api/v0/papers/"
    code_url = base_url + paper_id
    code_response = requests.get(code_url, verify=False).json()
    if "official" in code_response and code_response[]:
        github_code_url = code_response[]["url"]
    return github_code_url

# 获取github上项目的stars数量
def get_stars(github_code_url):
    try:
        # requests访问github上代码仓库主页
        code_html = requests.get(github_code_url, verify=False)
        # 利用BeautifulSoup库解析主页，爬取stars
        soup = BeautifulSoup(code_html.text, "html.parser")
        # stargazers /network/members /watchers
        a_stars = soup.find_all("a",
        href=github_code_url.split("https://github.com")[-1]+"stargazers")
        # 获取github上项目标星数
        stars = a_stars[0].text.strip().split()[0]
    except:
        stars = 0
    return stars

# 如何调用Edge浏览器的翻译API获取中文摘要
#翻译论文的摘要

# 从Edge浏览器对一篇英文文章进行翻译时，按下F12获取鉴权与翻译的API，以及对应的headers和API的调用方式。

# 获取Edge浏览器的鉴权信息
def get_edge_token():
    auth_url = "https://edge.microsoft.com/translate/auth"
    auth_headers = {
    "Content-Type": "text/plain; charset=utf-8"
    }
    Authorization = requests.get(auth_url, headers=auth_headers).text
    return Authorization

# 向翻译API发送预检信息

# 调用Edge浏览器的翻译接口，需要发送options预检请求，开放API的POST方法，将浏览器中的options操作下的所有headers复制到请求的headers中
def url_option():
    url = "https://api-edge.cognitive.microsofttranslator.com/translate?from=en&to=zh-CHS&api-version=3.0&includeSentenceLength=true"
    headers = { 用户的headers }
    # 发送请求
    requests.options(url, headers=headers)

# 调用翻译API
def get_translate(token, body):
    # 翻译API
    translate_url = ""
    translate_headers = {
        "Authorization": "Bearer " + str(token),
        "Content-Length": str(len(json.dumps(body, separators=(",", ":")))),
        : "application/json",
        "User-Agent": "浏览器代理"
    }
    res = requests.post(translate_url, headers=translate_headers, data=json.dumps(body, separators=(, )), verify=False)
    return res

#翻译内容

def translate_zh_to_en(contents):
    trans_contents = []
    trans_contents.append({"Text": contents})
    token = get_edge_token() # 获取翻译API的使用Token
    url_option() # 向API发送预检信息
    # 翻译摘要内容
    trans_text = get_translate(token, body=trans_contents).json()
    return trans_text[0]["translations"][0]["text"]

# 翻译论文摘要

# 调用edge浏览器免费的英文翻译API，对摘要进行翻译：

# 翻译中文摘要
paper_zh_summary = translate_zh_to_en(paper_summary)

