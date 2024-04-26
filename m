Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885ACC4345F
	for <lttng-dev@archiver.kernel.org>; Fri, 26 Apr 2024 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1714145595;
	bh=nWe3l6Fe+dPQm/u2FmraSeQcoAVjx7kdKfSWK8PY9xw=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=vP0LwwCAbdKrQGvGrU1OcrHwP80OKch7C7X5P6lO59YEMgcvGM05LdeeYq01guGN8
	 yG3c/Sm9RBjlDJteLZLOfHlHmYhQMRaPGO/pgjlooqlLmOsfQi5BClHHddZCVtZRpe
	 wVCAix+MBf+BrKTJYOovkSLkcSllC3wwi0tHJSCOf/JovFLBKo8lqiC3E0+l9WC6Gz
	 YtGijLk6j/7ZMOs87qn8Ytt/HZ9BhUWTvHi0U5OTOX9DC6W/BM9fv4orvykiLdhMHT
	 m+1S5ryeJ76qmYf7tsdMbcbF+6ePLm6l4vHI75ehRgKAEPbST0q1Y/FedipPwovoWC
	 bZsaH4BgPSBNQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VQxZL5QsHz2jk2;
	Fri, 26 Apr 2024 11:33:14 -0400 (EDT)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
 by lists.lttng.org (Postfix) with ESMTPS id 4VQxZK2K0Sz2jmy
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2024 11:33:13 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.07,232,1708387200"; 
 d="scan'208,217";a="721779607"
Thread-Topic: [lttng-dev] [babeltrace2]about python self-defined plugin loading
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 15:33:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:50588]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.159:2525]
 with esmtp (Farcaster)
 id 068d31f0-30f6-4987-a299-ed55753204b1; Fri, 26 Apr 2024 15:33:05 +0000 (UTC)
X-Farcaster-Flow-ID: 068d31f0-30f6-4987-a299-ed55753204b1
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 26 Apr 2024 15:33:04 +0000
Received: from EX19D003ANC001.ant.amazon.com (10.37.240.216) by
 EX19D003ANC001.ant.amazon.com (10.37.240.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 26 Apr 2024 15:33:03 +0000
Received: from EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8]) by
 EX19D003ANC001.ant.amazon.com ([fe80::ed4e:7258:fa8c:17e8%5]) with
 mapi id 15.02.1258.028; Fri, 26 Apr 2024 15:33:03 +0000
To: Simon Marchi <simark@simark.ca>, Kienan Stewart <kstewart@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Index: AQHalsCI/TKHXb5QNEKHKCHW1+CDTrF5IH2AgAAAiICAAXNMF4AAEm+AgAAJqGc=
Date: Fri, 26 Apr 2024 15:33:03 +0000
Message-ID: <4e5fe0af4bdf4c8dbbfcf63af9e55bfa@amazon.com>
References: <03304ae9731e474db911b8ef6703cf69@amazon.com>
 <b8b2da19-5c08-4369-9bd4-8a3ae554ac4f@efficios.com>
 <d00cba29-4ebc-4974-890c-ecf821b2fa8a@efficios.com>
 <8c49688cb4bb43009b5ba1f6fb8e32cf@amazon.com>,
 <52708661-b095-4f23-bfc7-9eb8c89f0cbe@simark.ca>
In-Reply-To: <52708661-b095-4f23-bfc7-9eb8c89f0cbe@simark.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.170.51]
MIME-Version: 1.0
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
From: "Wu, Yannan via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Wu, Yannan" <yannanwu@amazon.com>
Content-Type: multipart/mixed; boundary="===============6879146833162750467=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6879146833162750467==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4e5fe0af4bdf4c8dbbfcf63af9e55bfaamazoncom_"

--_000_4e5fe0af4bdf4c8dbbfcf63af9e55bfaamazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ok thanks for the help. I will try it later

Amanda

________________________________
From: Simon Marchi <simark@simark.ca>
Sent: Friday, April 26, 2024 10:57:59 PM
To: Wu, Yannan; Kienan Stewart; lttng-dev@lists.lttng.org
Subject: RE: [EXTERNAL] [lttng-dev] [babeltrace2]about python self-defined =
plugin loading

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



On 2024-04-26 09:56, Wu, Yannan via lttng-dev wrote:
> Hihi, Kienan,
>
> I finally find a workaround. I could success with the following code:
> file_name =3D "bt_plugin_latency_filter.py"
> current_directory=3Dos.getcwd()
>
> file_path =3D os.path.join(current_directory, file_name)
> pset=3Dbt2.find_plugins_in_path(file_path)
>
> forplugininpset:
> if plugin.name=3D=3D"latency_filter"andhasattr(plugin,"filter_component_c=
lasses"):
>
>     latency_filter_comp_cls=3Dplugin.filter_component_classes['LatencyFil=
ter']
>
> But loading the whole directory, it just doesnt work from command line.
> Amanda

So, since this works, it confirms that your babeltrace build has support
for Python plugins.  Then there's no reason for your original example
using babeltrace-fun-plugins/my-first-components not to work.

When running the command:

  babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink.demo.MyF=
irstSink

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
ENTRYPOINT babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink=
.demo.MyFirstSink
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

  $ babeltrace2 --log-level DEBUG --plugin-path . -c source.demo.MyFirstSou=
rce -c sink.demo.MyFirstSink

This will output all sorts of things about babeltrace looking for
plugins and trying to load them.

Simon

--_000_4e5fe0af4bdf4c8dbbfcf63af9e55bfaamazoncom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>ok thanks for the help. I will try it later <br>
</p>
<p>Amanda<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Simon Marchi &lt;si=
mark@simark.ca&gt;<br>
<b>Sent:</b> Friday, April 26, 2024 10:57:59 PM<br>
<b>To:</b> Wu, Yannan; Kienan Stewart; lttng-dev@lists.lttng.org<br>
<b>Subject:</b> RE: [EXTERNAL] [lttng-dev] [babeltrace2]about python self-d=
efined plugin loading</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">CAUTION: This email originated from outside of the=
 organization. Do not click links or open attachments unless you can confir=
m the sender and know the content is safe.<br>
<br>
<br>
<br>
On 2024-04-26 09:56, Wu, Yannan via lttng-dev wrote:<br>
&gt; Hihi, Kienan,<br>
&gt;<br>
&gt; I finally find a workaround. I could success with the following code:<=
br>
&gt; file_name =3D &quot;bt_plugin_latency_filter.py&quot;<br>
&gt; current_directory=3Dos.getcwd()<br>
&gt;<br>
&gt; file_path =3D os.path.join(current_directory, file_name)<br>
&gt; pset=3Dbt2.find_plugins_in_path(file_path)<br>
&gt;<br>
&gt; forplugininpset:<br>
&gt; if plugin.name=3D=3D&quot;latency_filter&quot;andhasattr(plugin,&quot;=
filter_component_classes&quot;):<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; latency_filter_comp_cls=3Dplugin.filter_compon=
ent_classes['LatencyFilter']<br>
&gt;<br>
&gt; But loading the whole directory, it just doesnt work from command line=
.<br>
&gt; Amanda<br>
<br>
So, since this works, it confirms that your babeltrace build has support<br=
>
for Python plugins.&nbsp; Then there's no reason for your original example<=
br>
using babeltrace-fun-plugins/my-first-components not to work.<br>
<br>
When running the command:<br>
<br>
&nbsp; babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink.dem=
o.MyFirstSink<br>
<br>
is your working directory babeltrace-fun-plugins/my-first-component?<br>
`--plugin-path .` refers to the current working directory, so it must be<br=
>
the directory that directly contains the `bt_plugin_*.py` file.<br>
<br>
I made an example with docker to show it working, hopefully this can<br>
help you figure out what's wrong on your side.&nbsp; Put this inside a<br>
`Dockerfile` file:<br>
<br>
```<br>
FROM debian:12<br>
<br>
RUN apt-get -y update<br>
RUN apt-get -y full-upgrade<br>
RUN apt-get -y install babeltrace2 git<br>
RUN git clone <a href=3D"https://github.com/simark/babeltrace-fun-plugins.g=
it">https://github.com/simark/babeltrace-fun-plugins.git</a><br>
WORKDIR /babeltrace-fun-plugins/my-first-components<br>
ENTRYPOINT babeltrace2 --plugin-path . -c source.demo.MyFirstSource -c sink=
.demo.MyFirstSink<br>
```<br>
<br>
Then, do either (whatever works for you):<br>
<br>
&nbsp; $ docker buildx build -t bt2-example .<br>
&nbsp; $ docker build -t bt2-example .<br>
<br>
And finally:<br>
<br>
&nbsp; $ docker run -it bt2-example<br>
&nbsp; Stream beginning<br>
&nbsp; event my-event, timestamp 123<br>
&nbsp; Stream end<br>
<br>
This last command runs babeltrace2, loading the Python plugin from<br>
babeltrace-fun-plugins/my-first-components.<br>
<br>
Finally, to investigate more in depth, you can increase the log level of<br=
>
babeltrace2, like so:<br>
<br>
&nbsp; $ babeltrace2 --log-level DEBUG --plugin-path . -c source.demo.MyFir=
stSource -c sink.demo.MyFirstSink<br>
<br>
This will output all sorts of things about babeltrace looking for<br>
plugins and trying to load them.<br>
<br>
Simon<br>
</div>
</span></font>
</body>
</html>

--_000_4e5fe0af4bdf4c8dbbfcf63af9e55bfaamazoncom_--

--===============6879146833162750467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6879146833162750467==--
