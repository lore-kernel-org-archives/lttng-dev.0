Return-Path: <SRS0=4dcy=AU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A34C433E0
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 13:15:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3C120708
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="j8NcJ8la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3C120708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B2c9P2hLnz1CPl;
	Thu,  9 Jul 2020 09:15:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594300522;
	bh=UB8R3HB4TXQDHmWmtTscy4ZgSPXEk1TwrY7hflCiGVg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j8NcJ8laH3dl7s8+/Znk8hX0X5YWm4St3vol+bC1zkoljpXuU/4M9P+1L+RPfegnA
	 kX2zsVheP2KqkBVFnr5JpsdKKlMvAmAZJP3ncuuEh6Op9JcUy+PX5YOGxHTbmwbOtK
	 beDGHt7QzLwhmOIuvnrxfbyw0RWtI3YCyw4wJNjKNFoOGRfmlcGdlKzyUHEZwdjaeJ
	 Q0p7lxso8IQzUO21PEAb5ixQMHGTxrCzAbmbcEqG8O/wDaS9c0xrYZE0jH6NTfQmb6
	 mVKfBbHQoI9rjtiE6DE7rWYL0r2KmV+8dVy/zm4kfzPok3BawtrZntm8/3KF9DMZTf
	 fkXdsaqOqu5Yg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4B2c9M5MCjz1CPk
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2020 09:15:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 405872871CD
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2020 09:15:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TBALzXKpn3YF; Thu,  9 Jul 2020 09:15:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CFC01287151;
 Thu,  9 Jul 2020 09:15:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CFC01287151
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VsLORUsF_nHa; Thu,  9 Jul 2020 09:15:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C15D728750D;
 Thu,  9 Jul 2020 09:15:16 -0400 (EDT)
Date: Thu, 9 Jul 2020 09:15:16 -0400 (EDT)
To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <434663210.6203.1594300516699.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABhb4uu6dxo_5pVUTXaz3qkGS41Ame77Bp5ePWT42cJ2PANFvA@mail.gmail.com>
References: <CABhb4uu6dxo_5pVUTXaz3qkGS41Ame77Bp5ePWT42cJ2PANFvA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: Payload of syscall_entry_execve
Thread-Index: /jX1tzgpzAmiTk9Wzv+7jAThXapupw==
Subject: Re: [lttng-dev] Payload of syscall_entry_execve
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============0641927688300105111=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200709131516.quUTu5DP6i-CpZuFUYccPLKRYDu09y4U_u_5LVSmmX8@z>

--===============0641927688300105111==
Content-Type: multipart/alternative; 
	boundary="=_3e5538b4-de5b-4046-a920-254be502c5e4"

--=_3e5538b4-de5b-4046-a920-254be502c5e4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 9, 2020, at 7:19 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hello!

> Currently, I'm developing a process monitor on the base of LTTng, and I face the
> challenge of accessing command-line arguments passed to execve syscall.
> I'm using LTTng live session and Babeltrace 2 C API to analyze events in online
> mode.

> syscall_entry_execve event has 3 payload fields: filename, argv, and envp. The
> first one is a normal C-string, the second and the third semantically are `char
> *const *`,
> but provided by LTTng as simple unsigned integers (the corresponding fields in
> Babaltrace2 event payload have type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,
> while I expect BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand, these
> integers are argv and envp pointers casted to uint64_t. But in the majority of
> cases, events produced by LTTng are analyzed by another process and often even
> offline, so these pointers became completely unuseful.

> Could you say, if there are some configuration parameters that enable to pass
> argv and envp content in syscall_entry_execve payload? Or some other ways to
> get this
> information from LTTng.

> P.S. I consider getting this information from /proc/pid/cmdline, but it is not
> looking like a clean solution.

The main reason why we don't implement this kind of instrumentation is because it would then 
capture security-sensitive data into the trace. Likewise for payload of read() and write() system 
calls for instance. 

I am not against instrumenting this information, but it should be done by add-on modules which 
can be compiled-out, and would be runtime-disabled by default. Also, we would need to extend the 
tracepoint instrumentation to identify fields which are security-sensitive, so they could be specifically 
disabled at runtime. This would also require CTF2 (Common Trace Format 2) to happen, so we can 
tag specific fields as containing sensitive data. Users should really know that they are tracing sensitive 
information when they do so. 

So adding the instrumentation to the project is not the hard part. The hard part is making sure it is 
configurable, not captured by default, and clearly identified in the traces. 

There is a second technical issue that would need solving for capturing argv and envp: we would need 
to ensure tracepoints hooked on system calls can take page faults, which is not possible today. The 
odds of taking a page fault when reading through argv and envp in a newly forked process are probably 
quite high, which would cause incomplete data. This cannot be solved in lttng-modules alone, we need 
to improve the kernel tracepoint instrumentation subsystem to do so. 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_3e5538b4-de5b-4046-a920-254be502c5e4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 9, 2020, at 7:19 AM, lttng-dev &lt;lttng-dev@lists.lttng.o=
rg&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div>Hello!</div><br><div>Currently, I'm developing a p=
rocess monitor on the base of LTTng, and I face the challenge of accessing =
command-line arguments passed to execve syscall.&nbsp;</div><div>I'm using =
LTTng live session and Babeltrace 2 C API to analyze events in online mode.=
</div><br><div>syscall_entry_execve&nbsp;event has 3 payload fields: filena=
me, argv, and envp. The first one is a normal C-string, the second and the =
third semantically&nbsp;are `char *const *`,&nbsp;</div><div>but provided b=
y LTTng as simple unsigned integers (the corresponding fields in Babaltrace=
2 event payload have type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,</div><div>w=
hile I expect BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand, t=
hese integers are argv and envp pointers casted to uint64_t. But in the maj=
ority of</div><div>cases, events produced by LTTng are analyzed by another =
process and often even offline, so these pointers became completely unusefu=
l.</div><br><div>Could you say, if there are some configuration parameters&=
nbsp;that enable to pass argv and envp content in syscall_entry_execve payl=
oad? Or some other ways to get this</div><div>information from LTTng.</div>=
<br><div>P.S. I consider getting this information from /proc/pid/cmdline, b=
ut it is not looking like a clean solution.</div></div></div></div></div></=
div></div></div></blockquote><div><br></div><div>The main reason why we don=
't implement this kind of instrumentation is because it would then</div><di=
v>capture security-sensitive data into the trace. Likewise for payload of r=
ead() and write() system</div><div>calls for instance.<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>I am not against instrum=
enting this information, but it should be done by add-on modules which<br d=
ata-mce-bogus=3D"1"></div><div>can be compiled-out, and would be runtime-di=
sabled by default. Also, we would need to extend the</div><div>tracepoint i=
nstrumentation to identify fields which are security-sensitive, so they cou=
ld be specifically</div><div>disabled at runtime. This would also require C=
TF2 (Common Trace Format 2) to happen, so we can</div><div>tag specific fie=
lds as containing sensitive data. Users should really know that they are tr=
acing sensitive</div><div>information when they do so.<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>So adding the instrument=
ation to the project is not the hard part. The hard part is making sure it =
is<br data-mce-bogus=3D"1"></div><div>configurable, not captured by default=
, and clearly identified in the traces.<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>There is a second technical issue that =
would need solving for capturing argv and envp: we would need<br data-mce-b=
ogus=3D"1"></div><div>to ensure tracepoints hooked on system calls can take=
 page faults, which is not possible today. The<br data-mce-bogus=3D"1"></di=
v><div>odds of taking a page fault when reading through argv and envp in a =
newly forked process are probably</div><div>quite high, which would cause i=
ncomplete data. This cannot be solved in lttng-modules alone, we need<br da=
ta-mce-bogus=3D"1"></div><div>to improve the kernel tracepoint instrumentat=
ion subsystem to do so.<br data-mce-bogus=3D"1"></div><div><br data-mce-bog=
us=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div></div><div><b=
r></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoye=
rs<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_3e5538b4-de5b-4046-a920-254be502c5e4--

--===============0641927688300105111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0641927688300105111==--
