# -*- coding: utf-8 -*-
import scrapy


class Opp2Spider(scrapy.Spider):
    name = 'itcast'
    allowed_domains = ['itcast.com']
    start_urls = ("http://www.itcast.cn/channel/teacher.shtml",)

    def parse(self, response):
        filename = "teacher.html"
        open(filename, 'w').write(str(response.body))

