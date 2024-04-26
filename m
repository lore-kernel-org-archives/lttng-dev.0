Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D3C4345F
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Apr 2024 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714143999;
	bh=0+724M0r3OJI4iokV9Xzjyhn2N/GCcSC2Rns7JpfeSc=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=t7/Ou6NJtz+t2XeAFdy0Cl/hOhSiUNWie6exrcBKHOoPIcbeCt4s0nj8kTe4KtLeV
	 gK1e3Up9hU4/vDOGd4DEOxT2YNXZHMMQFeNpNiWqtEU468mdVLW4L4N+0MuIJfy78p
	 Tl0xCH99dN3/pMRvsrBJd4mG72DdYuvg+qRM8UZkTKiEs6H9jnLK8BQtPZtH4qFIQ4
	 7HI9zYQrh87DXQoR2QWEDpBtjKMiy8N/oywEDbqniy5+WKUjzG9qQRGlSYgdta1lyX
	 c5jie8roHNbTHydh2/pUCJ4VdVLynkxht7Jeo86Dm0Tjk4pIdD94xXjDU7iDDDZnV8
	 a1wiklFaYwl2Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQwzf5y1zz2jmt;
	Fri, 26 Apr 2024 11:06:38 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQwzc369Vz2jvM
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2024 11:06:36 -0400 (EDT)
Received: from [10.0.0.11] (modemcable238.237-201-24.mc.videotron.ca
 [24.201.237.238])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id BB9AA1E092;
 Fri, 26 Apr 2024 10:57:59 -0400 (EDT)
Message-ID: <52708661-b095-4f23-bfc7-9eb8c89f0cbe@simark.ca>
Date: Fri, 26 Apr 2024 10:57:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Wu, Yannan" <yannanwu@amazon.com>, Kienan Stewart <kstewart@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <03304ae9731e474db911b8ef6703cf69@amazon.com>
 <b8b2da19-5c08-4369-9bd4-8a3ae554ac4f@efficios.com>
 <d00cba29-4ebc-4974-890c-ecf821b2fa8a@efficios.com>
 <8c49688cb4bb43009b5ba1f6fb8e32cf@amazon.com>
Content-Language: en-US
In-Reply-To: <8c49688cb4bb43009b5ba1f6fb8e32cf@amazon.com>
Subject: Re: [lttng-dev] [babeltrace2]about python self-defined plugin
 loading
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Simon Marchi <simark@simark.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



On 2024-04-26 09:56, Wu, Yannan via lttng-dev wrote:
> Hihi, Kienan,
> 
> I finally find a workaround. I could success with the following code:
> file_name = "bt_plugin_latency_filter.py"
> current_directory=os.getcwd()
> 
> file_path = os.path.join(current_directory, file_name)
> pset=bt2.find_plugins_in_path(file_path)
> 
> forplugininpset:
> if plugin.name=="latency_filter"andhasattr(plugin,"filter_component_classes"):
> 
>     latency_filter_comp_cls=plugin.filter_component_classes['LatencyFilter']
> 
> But loading the whole directory, it just doesnt work from command line.
> Amanda

So, since this works, it confirms that your babeltrace build has support
for Python plugins.  Then there's no reason for your original example
using babeltrace-fun-plugins/my-first-components not to work.

When running the command:

  babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink.demo.MyFirstSink

is your working directory babeltrace-fun-plugins/my-first-component?
`--plugin-path .` refers to the current working directory, so it must be
the directory that directly contains the `bt_plugin_*.py` file.

I made an example with docker to show it working, hopefully this can
help you figure out what's wrong on your side.  Put this inside a
`Dockerfile` file:

```
FROM debian:12

RUN apt-get -y update
RUN apt-get -y full-upgrade
RUN apt-get -y install babeltrace2 git
RUN git clone https://github.com/simark/babeltrace-fun-plugins.git
WORKDIR /babeltrace-fun-plugins/my-first-components
ENTRYPOINT babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink.demo.MyFirstSink
```

Then, do either (whatever works for you):

  $ docker buildx build -t bt2-example .
  $ docker build -t bt2-example .

And finally:

  $ docker run -it bt2-example
  Stream beginning
  event my-event, timestamp 123
  Stream end

This last command runs babeltrace2, loading the Python plugin from
babeltrace-fun-plugins/my-first-components.

Finally, to investigate more in depth, you can increase the log level of
babeltrace2, like so:

  $ babeltrace2 --log-level DEBUG --plugin-path . -c source.demo.MyFirstSource -c sink.demo.MyFirstSink

This will output all sorts of things about babeltrace looking for
plugins and trying to load them.

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
