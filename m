Return-Path: <SRS0=0DGv=IH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF01DC433DB
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 13:11:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3133F6514A
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Mar 2021 13:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3133F6514A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DvwZr1LXczFDh;
	Tue,  9 Mar 2021 08:11:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615295492;
	bh=vlyOyhi7upmXKhWFBtac9TmWoxLmfXZCQcJ14lijcyo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=TgczUBj0zSfyzP/yQ1VYkENha5VmvtOT+vKJ1rBvbATVmwHk+yrq1olMRdvLiH4D3
	 7jePYydRT6xZKGnnya9lpEq82VEUZww4SeXn1fT8Mp36yah6dRfkfD4WtOioPLmvao
	 HkcjvqggiN9uqAyGDEodVHNDaX6o/7G6Zfl7m+scATyFltPFMkd2O5lBLg4HjwnllG
	 HuVtvlmJ5eTblS98dJB1nXlFCGN2j1rP+kMoUFDWDOvQX3oGX8Ly1VjMV4NA0v4As4
	 YtPP3/S/BOKm34c8tTcd/81BYnpSotlopALcp0Hw8NrcGh4dlpgss38A9yMLdCoHgw
	 qlbp+tAmtow4Q==
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by lists.lttng.org (Postfix) with ESMTPS id 4DvwZp6BzwzFDf
 for <lttng-dev@lists.lttng.org>; Tue,  9 Mar 2021 08:11:30 -0500 (EST)
IronPort-SDR: 24QX8zaLM6HAQG14rYQ31Fh6X/ioLtiE3ZCYcwa/PUBtZA9NXlNJJZ3VcRmXLV4tpmB9fWNzwG
 4uX0xk55xaZsu18eoCIua9aCbSZRfLYHkPHhl2jSCSZ5EIpIYLJbunaoQK/IZFzFQWTpa2TB+r
 lkcA3wSlbVocykz1NyHDU9tvyzYxF/HJfIRtzwLu8GEDJ2YSCzKQfzPF4gPDT1TpnB2znmdunI
 5nnGrYeCzdeM7TlO8HWo06aUKFtOZeJlmRkel6T5w6w4rXawNJ9yIdYs6vaL1zvNs48FDXwjPA
 wcs=
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; d="scan'208,217";a="61232238"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 09 Mar 2021 05:10:13 -0800
IronPort-SDR: EDYSAx2mc7Izv2jcgospUUF4lu468NfdZtbZjWedNML11smGiePf4zA8egmiBjsLFnlgg/hfNw
 8EpbbRMHDKDd1wVh3S9dr5Xfbo8dknyjAp1W9UtDunz7BynPKh1I6yyvJE7uDDbpaHyfX0ArkY
 9s677m2qhiEJXQiY0cPG+XExB2bKFfmOO5mCUXPK1COMWQSRj48tMh4WriallHCfioJOk7KaaJ
 cXpNmUbHmES7MKu9CYRJE0+XElcw4Kb82NuIPgORTjFwf1ZtqkK2VsRRvCogDqLV8U16pYUErF
 6AA=
To: <lttng-dev@lists.lttng.org>
Message-ID: <f02c9dd6-b95c-19be-a7b0-cca3efda149c@mentor.com>
Date: Tue, 9 Mar 2021 18:10:07 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-US
Subject: [lttng-dev] lttng-modules: block: invalid/unknown value for rwbs
 field
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Awais Belal via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Awais Belal <awais_belal@mentor.com>
Content-Type: multipart/mixed; boundary="===============4005434250625999211=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4005434250625999211==
Content-Type: multipart/alternative;
	boundary="------------B531300889DC06FD36D0A7B5"
Content-Language: en-US

--------------B531300889DC06FD36D0A7B5
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am using lttng-modules 2.12.5 with a 5.4.93 kernel on an aarch64 
target. After creating a session I run

*lttng enable-event -k block**

to enable all the block_ kernel events but when I run babeltrace on the 
generated traces I get a handful of

*[warning] Unknown value 33 in enum.
...
...
*

with different values in place of 33. This does not happen with any 
other kernel event type

*BabelTrace Trace Viewer and Converter 1.5.8*

Also if I try to do a 'lttng view' on this session I can identify that 
this has something to do with the rwbs field as I get

*[14:03:42.649719750] (+0.000005750) imx8qxpmek block_bio_remap: { 
cpu_id = 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs = 
( <unknown> : container = 33 ), old_dev = 187695203, old_sector = 2105776 }
[14:03:42.649722125] (+0.000002375) imx8qxpmek block_bio_queue: { cpu_id 
= 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs = ( 
<unknown> : container = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }
[14:03:42.649725000] (+0.000002875) imx8qxpmek block_bio_backmerge: { 
cpu_id = 3 }, { dev = 187695200, sector = 2460080, nr_sector = 8, rwbs = 
( <unknown> : container = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }
...
...*

I believe <unknown> in the log points to a symptom? While for the 
events/container id that do not generate this warning I have in the same 
trace

*[14:03:44.697572375] (+2.036943500) imx8qxpmek block_bio_remap: { 
cpu_id = 0 }, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs = 
( "RWBS_FLAG_WRITE" : container = 1 ), old_dev = 187695206, old_sector = 
278672 }
[14:03:44.697584375] (+0.000012000) imx8qxpmek block_bio_queue: { cpu_id 
= 0 }, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs = ( 
"RWBS_FLAG_WRITE" : container = 1 ), tid = 1609, comm = "kworker/u8:0" }
[14:03:44.697604250] (+0.000019875) imx8qxpmek block_getrq: { cpu_id = 0 
}, { dev = 187695200, sector = 9382032, nr_sector = 8, rwbs = ( 
"RWBS_FLAG_WRITE" : container = 1 ), tid = 1609, comm = "kworker/u8:0" }*

The interesting thing to note with the working events is that all of 
them have "RWBS_FLAG_WRITE" and no other types from 
https://github.com/lttng/lttng-modules/blob/stable-2.12/instrumentation/events/lttng-module/block.h#L39 
which I would expect to see.

I am lost for hints as to what I need to look up... any help would be 
highly appreciated.

-- 
BR,
Awais


--------------B531300889DC06FD36D0A7B5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="Tahoma">Hi,</font></p>
    <p><font face="Tahoma">I am using lttng-modules 2.12.5 with a 5.4.93
        kernel on an aarch64 target. After creating a session I run<br>
        <br>
        <b><font size="-1">lttng enable-event -k block*</font></b><br>
      </font></p>
    <p><font face="Tahoma">to enable all the block_ kernel events but
        when I run babeltrace on the generated traces I get a handful of<br>
      </font></p>
    <p><b><font size="-1" face="Tahoma">[warning] Unknown value 33 in
          enum.<br>
          ...<br>
          ...<br>
        </font></b></p>
    <p><font face="Tahoma">with different values in place of 33. This
        does not happen with any other kernel event type<br>
      </font></p>
    <p><font face="Tahoma"><b><font size="-1">BabelTrace Trace Viewer
            and Converter 1.5.8</font></b><br>
      </font></p>
    <p><font face="Tahoma">Also if I try to do a 'lttng view' on this
        session I can identify that this has something to do with the
        rwbs field as I get</font></p>
    <p><font face="Tahoma"><b><font size="-1">[14:03:42.649719750]
            (+0.000005750) imx8qxpmek block_bio_remap: { cpu_id = 3 }, {
            dev = 187695200, sector = 2460080, nr_sector = 8, rwbs = (
            &lt;unknown&gt; : container = 33 ), old_dev = 187695203,
            old_sector = 2105776 }<br>
            [14:03:42.649722125] (+0.000002375) imx8qxpmek
            block_bio_queue: { cpu_id = 3 }, { dev = 187695200, sector =
            2460080, nr_sector = 8, rwbs = ( &lt;unknown&gt; : container
            = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }<br>
            [14:03:42.649725000] (+0.000002875) imx8qxpmek
            block_bio_backmerge: { cpu_id = 3 }, { dev = 187695200,
            sector = 2460080, nr_sector = 8, rwbs = ( &lt;unknown&gt; :
            container = 33 ), tid = 428, comm = "jbd2/mmcblk1p3-" }<br>
            ...<br>
            ...</font></b><br>
      </font></p>
    <p><font face="Tahoma">I believe &lt;unknown&gt; in the log points
        to a symptom? While for the events/container id that do not
        generate this warning I have in the same trace</font></p>
    <p><font face="Tahoma"><b><font size="-1">[14:03:44.697572375]
            (+2.036943500) imx8qxpmek block_bio_remap: { cpu_id = 0 }, {
            dev = 187695200, sector = 9382032, nr_sector = 8, rwbs = (
            "RWBS_FLAG_WRITE" : container = 1 ), old_dev = 187695206,
            old_sector = 278672 }<br>
            [14:03:44.697584375] (+0.000012000) imx8qxpmek
            block_bio_queue: { cpu_id = 0 }, { dev = 187695200, sector =
            9382032, nr_sector = 8, rwbs = ( "RWBS_FLAG_WRITE" :
            container = 1 ), tid = 1609, comm = "kworker/u8:0" }<br>
            [14:03:44.697604250] (+0.000019875) imx8qxpmek block_getrq:
            { cpu_id = 0 }, { dev = 187695200, sector = 9382032,
            nr_sector = 8, rwbs = ( "RWBS_FLAG_WRITE" : container = 1 ),
            tid = 1609, comm = "kworker/u8:0" }</font></b><br>
      </font></p>
    <p><font face="Tahoma">The interesting thing to note with the
        working events is that all of them have "</font><font
        face="Tahoma"><font face="Tahoma">RWBS_FLAG_WRITE</font>" and no
        other types from
<a class="moz-txt-link-freetext" href="https://github.com/lttng/lttng-modules/blob/stable-2.12/instrumentation/events/lttng-module/block.h#L39">https://github.com/lttng/lttng-modules/blob/stable-2.12/instrumentation/events/lttng-module/block.h#L39</a>
        which I would expect to see.</font></p>
    <p><font face="Tahoma">I am lost for hints as to what I need to look
        up... any help would be highly appreciated.</font><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
BR,
Awais</pre>
  </body>
</html>

--------------B531300889DC06FD36D0A7B5--

--===============4005434250625999211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4005434250625999211==--
