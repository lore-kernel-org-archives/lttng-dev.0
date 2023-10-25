Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74339C07545
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Oct 2023 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698247871;
	bh=rEw8aOaQ8AbiaNVjH7VJ3PCqSeDC0lxg9f3l6PmyFGE=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=jr2/dN+1C5cJo08hhyTOTFXBxczDt/6Xx29z8XQTu6JM0pTUho6G/ZQsfBxtPDTNo
	 vqzlA+Qhm3CMguB84TUEFkb5u8D3BHWDKFm+FVa1JwIXJYm3ORidBHnRiZqmf51JCu
	 ZFTr01USER8UIt347C9FVtMH+7lGNpm57dBO2wfjjGMCmujtJm2YWD3D3YV8agWCqJ
	 I33FB/uSf2QGonbFn1x9a19wiT2fVuI67r7nn+Iob9dVrDdqiR72rx+/QBC1b8yU7u
	 CNh8ax3vcytlu+3zLm8LpeVGR+IlWjMaNM7nO91RoNLde0LrhLCMuynXvROQVSctpg
	 40w53N9GWNobQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SFtDt42Bfz8R4;
	Wed, 25 Oct 2023 11:31:10 -0400 (EDT)
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 4SFtDs2BM0z8R2
 for <lttng-dev@lists.lttng.org>; Wed, 25 Oct 2023 11:31:09 -0400 (EDT)
Received: from [172.16.0.192] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by simark.ca (Postfix) with ESMTPSA id BDCF71E00F;
 Wed, 25 Oct 2023 11:31:07 -0400 (EDT)
Message-ID: <d3c4203d-009f-422a-b75e-8c5c7fb9fa84@simark.ca>
Date: Wed, 25 Oct 2023 11:31:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr
To: "Seidl, Aron" <aron.seidl@zeiss.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <AM9P190MB107537176AB808CA2F55AA2488DFA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
 <f0ca6352-ee2e-4943-8375-a228557eb49c@simark.ca>
 <AM9P190MB1075EE7CA033D45006FCDB0D88DEA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P190MB1075EE7CA033D45006FCDB0D88DEA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
Subject: Re: [lttng-dev] Debugging Libaries in Babeltrace 2
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

On 10/25/23 03:29, Seidl, Aron via lttng-dev wrote:
> Hi Simon,
> Thanks for your quick answer!
> I run GDB like this:
> gdb --args ./babeltrace2 /home/aron/Schreibtisch/kernel4 -o text
> (I'm in src/cli/.libs)

Don't do that (try to debug the binary in .libs directly).

> I don't think I've ever installed a System Version of babeltrace2, so it is really weird that GDB uses following library:
> 
> 0x00007ffff7f36f00  0x00007ffff7f89749  Yes (*)     /lib/x86_64-linux-gnu/libbabeltrace2.so.0
> (*): Shared library is missing debugging information.

It might have been installed as a dependency of another package, I don't
know.

> And you're absolutely right! That is the reason why I can't debug it.
> Is there a way to specify the library path? Because even with the libtool wrapper, GDB uses the release version of libbabeltrace2.so.0.

Can you run this *in the root of your build tree* and show the output?
We should see a path to libbabeltrace2.so inside your build tree.

$ libtool --mode=execute gdb -q -batch src/cli/babeltrace2 -ex start -ex "info shared"

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
