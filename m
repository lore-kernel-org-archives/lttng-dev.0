Return-Path: <SRS0=tnGF=BB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88CC433E7
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6766B2065F
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="nMkOEbLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6766B2065F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BBbbD4vdyz1dsC;
	Wed, 22 Jul 2020 09:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595423816;
	bh=fdd9Xtm5NVOR1MP8kMtYWCFRjusPoiNqNIYwd44jWRE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=nMkOEbLlqrfvSdq3H2DxYLJ6ksnafjtlDKL7AIZFOOOQVem7HhKPzIfSCyhxGVZuE
	 EgUDb9toyqv4Xf9ewi4DoGn3Mb2QKRdu7VfngxWoASkEOA4N+DxHKnIBTm/Vd6HHI4
	 7ifru6taPVnSBYpGvfH773pMqQ3tAkHo7Bf6JQiTTa9cyH6riqafdpW4Vp/KQXdecT
	 9QJOvCf/yKDKw035Avcby9nTkKTYarsRQimjilKfMK50T29ZDwA2ANXOrqgt/MqCws
	 HoslIfW3MxKwybmxCnnIOvV3foTdkowl/NDkj/QRxI1NZ2OF5bH1F/0IUnfyPEDvMJ
	 L3i6FWMMA+Geg==
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.115])
 by lists.lttng.org (Postfix) with ESMTPS id 4BBSXC0F4Nz1dZ8
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 03:58:50 -0400 (EDT)
Received: from [100.112.135.148] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-b.us-west-2.aws.symcld.net id E1/46-29188-DA1F71F5;
 Wed, 22 Jul 2020 07:58:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRWlGSWpSXmKPExsVyqPAOq+6aj+L
 xBke36Fh0XO9hdmD0eL/gD3MAYxRrZl5SfkUCa8bHw9/ZCn7LVWx/PJm9gfGhdBcjF4eQwCZG
 iT3bWpjhnHP7bzF1MXICOQcZJS53uIDYbAK6Eq8ePGUGsUUErCWuLboHZHNwCAu4SPx6LwkR9
 pRYuXQCK4StJ/Hl3DSwchYBVYmzb++xgNi8Au4SW5tOs4PYjAJiEt9PrQFbxSwgLnHryXwwW0
 JAQGLJnvPMELaoxMvH/1ghbAOJrUv3sUDYchLLtj+H6tWRWLD7ExuErS2xbOFrZohdghInZz5
 hgXhFWWLWii9sExhFZiFZNwtJ+ywk7bOQtC9gZFnFaJ5UlJmeUZKbmJmja2hgoGtoaKRraGyi
 a2mpl1ilm6RXWqxbnlpcomukl1herFdcmZuck6KXl1qyiREYNSkFbck7GBvffNA7xCjJwaQky
 st9UjxeiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv8AegnGBRanpqRVpmDjCCYdISHDxKIrwH3w
 OleYsLEnOLM9MhUqcY7TkmvJy7iJlj59F5QPIgmGy+s2QRsxBLXn5eqpQ4rwzIVAGQtozSPLi
 hsIRziVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw70qQ5TyZeSVwu18BncUEdJbyXVGQs0oS
 EVJSDUw5bsq3r218NU3cw8jW65fB2TNRmn5LJL+IJP8tfyyZU++71+ZUTL1j1eqo0sUvmmI4B
 XZNnev8oyLR6WxlbcwJS2VZR577dTPubKji/6Yovyf1kvkxo+3znvp/Ss12dN+zON6d4+8GL4
 U5th03TobvCdC4Ex+au6rASja7kF2cQ3b2qp+i585duSLpfX8u2yQBc3Yb5iWNveqPvugd9lq
 2pPFHl1zx7lszpBx/bz6SInD6Y/Z6y1Sr7n83UthrTrNq2/jYvron+5+pOPvafulzd3Rq93dv
 sdj9dm3uNCXphte86o7Ch1O5Fa929xyVdPkx61Bp7JvkslDXH/xCZ241iodNl98T1XqLfwXfd
 SWW4oxEQy3mouJEAC7FbV2zAwAA
X-Env-Sender: Seongab.Kim@harman.com
X-Msg-Ref: server-30.tower-357.messagelabs.com!1595404712!52363!2
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8253 invoked from network); 22 Jul 2020 07:58:36 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
 by server-30.tower-357.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted
 SMTP; 22 Jul 2020 07:58:36 -0000
Received: from DEMDWSMB24.ad.harman.com (10.70.51.6) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 09:58:32 +0200
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
 DEMDWSMB24.ad.harman.com (10.70.51.6) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 09:58:32 +0200
Received: from HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452]) by
 HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452%16]) with mapi id
 15.00.1497.000; Wed, 22 Jul 2020 09:58:32 +0200
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: babeltrace cannot open the trace but Trace Compass can open
Thread-Index: AdZf/Vg1h1OXj4+FT3ak2QkPQmA8lQ==
Date: Wed, 22 Jul 2020 07:58:32 +0000
Message-ID: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.50.4]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Jul 2020 09:16:49 -0400
Subject: [lttng-dev] babeltrace cannot open the trace but Trace Compass can
 open
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200722075832.5Da50lgq4QuN_jwj0xB6R4h4c9WrfBoG9QtVf7Wk4KE@z>

Hi,

I have a trace which cannot be opened by babeltrace as below, but I can open it with Trace Compass.

skim@d54030999178:/mnt/ssd/work/skim/traces$ babeltrace2  ./kernel/
07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR get_unary_unsigned@visitor-generate-ir.c:800 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Invalid constant unsigned integer.
07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl_entry@visitor-generate-ir.c:4357 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Unexpected unary expression for clock class's `offset` attribute.
07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl@visitor-generate-ir.c:4532 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Cannot visit clock class's entry: ret=-22
07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR ctf_visitor_generate_ir_visit_node@visitor-generate-ir.c:4775 [auto-disc-source-ctf-fs] At line 41 in metadata stream: Cannot visit clock class: ret=-22
07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/DECODER ctf_metadata_decoder_append_content@decoder.c:337 [auto-disc-source-ctf-fs] Failed to visit AST node to create CTF IR objects: mdec-addr=0x22a0d90, ret=-22
07-22 07:49:20.099  5264  5264 E PLUGIN/SRC.CTF.FS/META ctf_fs_metadata_set_trace_class@metadata.c:128 [auto-disc-source-ctf-fs] Cannot update metadata decoder's content.
07-22 07:49:20.122  5264  5264 E PLUGIN/SRC.CTF.FS ctf_fs_component_create_ctf_fs_trace_one_path@fs.c:1206 [auto-disc-source-ctf-fs] Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.
07-22 07:49:20.123  5264  5264 W LIB/GRAPH add_component_with_init_method_data@graph.c:977 Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING, comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0, comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so", comp-input-port-count=0, comp-output-port-count=0
07-22 07:49:20.123  5264  5264 E CLI cmd_run_ctx_create_components_from_config_components@babeltrace2.c:2301 Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
07-22 07:49:20.123  5264  5264 E CLI cmd_run@babeltrace2.c:2480 Cannot create components.

ERROR:    [Babeltrace CLI] (babeltrace2.c:2480)
  Cannot create components.
CAUSED BY [Babeltrace CLI] (babeltrace2.c:2301)
  Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
CAUSED BY [libbabeltrace2] (graph.c:977)
  Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING,
  comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0,
  comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so",
  comp-input-port-count=0, comp-output-port-count=0
CAUSED BY [auto-disc-source-ctf-fs: 'source.ctf.fs'] (fs.c:1206)
  Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.

Could someone can advise me how to open the trace with babeltrace?
I'm using below version.

skim@d54030999178:~/work/tmp$ babeltrace2 -V Babeltrace 2.0.4 "Amqui"

Amqui (/_mkwi_/) is a town in eastern Qu_bec, Canada, at the base of the Gasp_ peninsula in Bas-Saint-Laurent. Located at the confluence of the Humqui and Matap_dia Rivers, its proximity to woodlands makes it a great destination for outdoor activities such as camping, hiking, and mountain biking.

Best regards,
Seongab Kim

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
