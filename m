Return-Path: <SRS0=tnGF=BB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8476CC433E4
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 15:06:47 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0AE20658
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="OPT8w95D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0AE20658
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BBf1x6GvTz1f3d;
	Wed, 22 Jul 2020 11:06:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595430406;
	bh=ME0QC7Z5JxX/x7AbXiR3RL7r0ybHn6MJlkEEUzDriqA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OPT8w95DfyaDtWmABJQT6jtKBtndfwfBt41DGPB1cC16nZnqZSUxwPJGEC/QHp2Ts
	 xZEI4fewN33BQzLjg2ZIr2PuZKZSgCXQvXVQ+PSPt/oa0eh+RJbSGvecBoLibYX898
	 7/gpReh0Edw/SVJ6mehAF6oBGzawG3fv4v0ahoy4ayY8YwNabB3DQOIxGjhzEh7/L+
	 +g02ZynFEZKTn/9H3XVYyU/iv3v2TEsydFoRBAKr7nGSrouT8799SQOnzYQswvCeIg
	 EmezKDgXzsiF3BRWWtzMNcbKRXiqOprU+W7BiMJs3j7qt9wAHIowaW56+9Y6tTaRJK
	 FLuWOGJTs0reA==
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by lists.lttng.org (Postfix) with ESMTPS id 4BBf1w4mfgz1fB4
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 11:06:44 -0400 (EDT)
Received: by mail-yb1-xb36.google.com with SMTP id a15so1167867ybs.8
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 08:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cicxAiZOfQzw0OPKR2icqVivQaX7Dg5AjsIrQEq8P1g=;
 b=INEWCFjWexzYFN0RQ+XKtEzixiXSVaJclxyiJ4j8rpCy6Va3FxkI/0isxWJ8VMnBrz
 ZncFAzAur44j8q1QKFdjZkg7TrduDe+KR3xbts+fpdHmYpzReQa1S/ujRVuyUTYhO9bK
 M84dHRUR8ZQHqU0Uij4Ae3wfu4Qhl3FpGmS1hPcaIDDtvFGa1A/+cscgXGpt91Oj5q1y
 0SzCT/AmD+RofQgP58KLroTgMtUEN8s5rz6fR2PdfCMRsH5me0aI3Ahn/QHcdhQT4R34
 LlwpWZOA9D/VBRGksggnOEBOhUjRQ/9mUmkKrUWkPk3Y/q23y0wpR9cyHL+65i2wuN/A
 HhMg==
X-Gm-Message-State: AOAM532DH5qLssqgCJBuoAddG6DkU2e/I8FpE/P+spKOeoRe8cFz6U9u
 W2SUVxc/XabB8TAEG3Nnegfmun4aeHtcq8PaCBuXlf3P8do=
X-Google-Smtp-Source: ABdhPJzauLYuiI4dnjFmHFT/hr6p1kgOz9/GIOm3+DMB4ms/9lIGHWia7ez88SmqzdLU0fVVuWy+APq1isBQLwIUv3U=
X-Received: by 2002:a25:6854:: with SMTP id d81mr49621171ybc.316.1595430403849; 
 Wed, 22 Jul 2020 08:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
In-Reply-To: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
Date: Wed, 22 Jul 2020 11:06:16 -0400
Message-ID: <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
To: "Kim, Seongab" <Seongab.Kim@harman.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] babeltrace cannot open the trace but Trace Compass
 can open
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200722150616.TVrdxstLXPAiB1k3B6sv_bQ4mLcyi842Wrac20dQn90@z>

Thank you for the bug report.

Can I kindly ask you to create an official issue for this?

Go to <https://bugs.lttng.org/projects/babeltrace/issues/new>.

I'd also like you to attach the offending CTF trace so that I can
analyze it if it doesn't contain sensitive data and is somewhat small.
If it's not possible, do:

    $ babeltrace2 -o ctf-metadata /mnt/ssd/work/skim/traces/kernel |
grep -A10 '^clock {'

and copy the output to the Redmine issue's description.

BR,

Phil

On Wed, Jul 22, 2020 at 9:17 AM Kim, Seongab via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi,
>
> I have a trace which cannot be opened by babeltrace as below, but I can open it with Trace Compass.
>
> skim@d54030999178:/mnt/ssd/work/skim/traces$ babeltrace2  ./kernel/
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR get_unary_unsigned@visitor-generate-ir.c:800 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Invalid constant unsigned integer.
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl_entry@visitor-generate-ir.c:4357 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Unexpected unary expression for clock class's `offset` attribute.
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR visit_clock_decl@visitor-generate-ir.c:4532 [auto-disc-source-ctf-fs] At line 40 in metadata stream: Cannot visit clock class's entry: ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/IR-VISITOR ctf_visitor_generate_ir_visit_node@visitor-generate-ir.c:4775 [auto-disc-source-ctf-fs] At line 41 in metadata stream: Cannot visit clock class: ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/CTF/META/DECODER ctf_metadata_decoder_append_content@decoder.c:337 [auto-disc-source-ctf-fs] Failed to visit AST node to create CTF IR objects: mdec-addr=0x22a0d90, ret=-22
> 07-22 07:49:20.099  5264  5264 E PLUGIN/SRC.CTF.FS/META ctf_fs_metadata_set_trace_class@metadata.c:128 [auto-disc-source-ctf-fs] Cannot update metadata decoder's content.
> 07-22 07:49:20.122  5264  5264 E PLUGIN/SRC.CTF.FS ctf_fs_component_create_ctf_fs_trace_one_path@fs.c:1206 [auto-disc-source-ctf-fs] Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.
> 07-22 07:49:20.123  5264  5264 W LIB/GRAPH add_component_with_init_method_data@graph.c:977 Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING, comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0, comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so", comp-input-port-count=0, comp-output-port-count=0
> 07-22 07:49:20.123  5264  5264 E CLI cmd_run_ctx_create_components_from_config_components@babeltrace2.c:2301 Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
> 07-22 07:49:20.123  5264  5264 E CLI cmd_run@babeltrace2.c:2480 Cannot create components.
>
> ERROR:    [Babeltrace CLI] (babeltrace2.c:2480)
>   Cannot create components.
> CAUSED BY [Babeltrace CLI] (babeltrace2.c:2301)
>   Cannot create component: plugin-name="ctf", comp-cls-name="fs", comp-cls-type=1, comp-name="auto-disc-source-ctf-fs"
> CAUSED BY [libbabeltrace2] (graph.c:977)
>   Component initialization method failed: status=ERROR, comp-addr=0x22a68d0, comp-name="auto-disc-source-ctf-fs", comp-log-level=WARNING,
>   comp-class-type=SOURCE, comp-class-name="fs", comp-class-partial-descr="Read CTF traces from the file sy", comp-class-is-frozen=0,
>   comp-class-so-handle-addr=0x22b0de0, comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-ctf.so",
>   comp-input-port-count=0, comp-output-port-count=0
> CAUSED BY [auto-disc-source-ctf-fs: 'source.ctf.fs'] (fs.c:1206)
>   Cannot create trace for `/mnt/ssd/work/skim/traces/kernel`.
>
> Could someone can advise me how to open the trace with babeltrace?
> I'm using below version.
>
> skim@d54030999178:~/work/tmp$ babeltrace2 -V Babeltrace 2.0.4 "Amqui"
>
> Amqui (/_mkwi_/) is a town in eastern Qu_bec, Canada, at the base of the Gasp_ peninsula in Bas-Saint-Laurent. Located at the confluence of the Humqui and Matap_dia Rivers, its proximity to woodlands makes it a great destination for outdoor activities such as camping, hiking, and mountain biking.
>
> Best regards,
> Seongab Kim
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
