import requests
from bs4 import BeautifulSoup
from numpy import mat, zeros
import scipy.io as sio
import html5lib

import fields

search_url = 'http://www.cuilab.cn/dmiapp/search/'
headers = {'Accept': '*/*',
           'Accept-Encoding': 'gzip, deflate',
           'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
           'Cache-Control': 'no-cache',
           'Connection': 'keep-alive',
           'Content-Length': '23',
           'Content-Type': 'application/x-www-form-urlencoded',
           'Host': 'www.cuilab.cn',
           'Origin': 'http://www.cuilab.cn',
           'Pragma': 'no-cache',
           'Referer': 'http://www.cuilab.cn/hmdad',
           'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36',
           'X-Requested-With': 'XMLHttpRequest'}

err_hint = b'\n    <p style="font-size:140%; color:red; margin:0 0 0 60px;">No entry matched your search.</p>\n\n'


def request_microbes(disease_name):
    data = {'entry': disease_name, 'type': 'disea'}
    response = requests.post(search_url, data=data, headers=headers)
    if response.content == err_hint:
        raise Exception('Disease not in dataset')
    return html2obj(disease_name, response.content)


def html2obj(disease, html):
    soup = BeautifulSoup(html, 'html5lib')
    data_list = []
    for idx, tr in enumerate(soup.find_all('tr')):
        if idx != 0:
            tds = tr.find_all('td')
            if tds[0].contents[0] == disease:
                data_list.append(tds[1].contents[0])
    return data_list


def get_microbe_list():
    f = open(fields.microbes_txt)
    m_list = []
    while True:
        line = f.readline().splitlines()
        if not line:
            break
        m_list.append(line[0])
    return m_list


if __name__ == '__main__':
    d_m_matrix = zeros((39, 292), dtype=int)
    position = 0
    d_m_dict = dict()
    m_list = get_microbe_list()

    f = open(fields.diseases_txt)
    while True:
        line = f.readline().splitlines()
        if not line:
            break
        microbes = request_microbes(line[0])
        for microbe in microbes:
            try:
                index = m_list.index(microbe)
            except:
                if microbe == 'Lactobacillus  crispatus':
                    index = m_list.index('Lactobacillus crispatus')
            d_m_matrix[position][index] = 1
        position = position + 1
    sio.savemat('d_m_mat.mat', {'d_m_mat': mat(d_m_matrix, dtype='double')})
