Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A1C433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  7 Dec 2021 20:08:11 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J7rvY3f09z1rWS;
	Tue,  7 Dec 2021 15:08:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1638907690;
	bh=J47RgJ1D9Zq6jezeKTW4gqnVSR02QjhtY7hLd7DgssU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=F7MAVsOG3vLAJY7QJGENYOeQA55DHgqY5bDNIj81lTCVxSE2rWrda+BMjvT831IKT
	 9trxf8ffX5FR2mjI2B1V4rK4Sv7wGth4pIGlV29Iuj2jDWFJvkrJ/eZf7fFMo6qUvp
	 2jRWNlSuyDA3jpYuSS4OpWdNklKvGYXvcwxaORdPFqmm4vJEfhE7F5FQtkRoc6bR7u
	 wBNLgYfoPq4lhJK49R+GpS0Fx8jVCbdtu3Y6L0EioSKftun1nzhboKjPLmdI9BKtkf
	 S2GVzLRMzj6e3cDU77UGwq5f/1YTA3a1CztiTX0oR1Etp8DIXX9Ss1eqiHq4RtJkp+
	 85D/FnfdQNy7w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J7rvW0Bt4z1rWQ
 for <lttng-dev@lists.lttng.org>; Tue,  7 Dec 2021 15:08:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B976339FC17
 for <lttng-dev@lists.lttng.org>; Tue,  7 Dec 2021 15:08:00 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id MOBefnBbORru; Tue,  7 Dec 2021 15:07:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D638B39FC11;
 Tue,  7 Dec 2021 15:07:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D638B39FC11
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9uD27mGLcjEY; Tue,  7 Dec 2021 15:07:59 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C620C39FC10;
 Tue,  7 Dec 2021 15:07:59 -0500 (EST)
Date: Tue, 7 Dec 2021 15:07:59 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1503888133.17265.1638907679680.JavaMail.zimbra@efficios.com>
In-Reply-To: <6ad73114-861c-46e3-8f9e-1076e482116f.zhenyu.ren@aliyun.com>
References: <6ad73114-861c-46e3-8f9e-1076e482116f.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: lttng-consumerd can NOT get notification to consume ring buffer
 data
Thread-Index: e3+roufjAnMbGS13hUMAXHwRr8O6Dw==
Subject: Re: [lttng-dev] lttng-consumerd can NOT get notification to consume
 ring buffer data
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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
Content-Type: multipart/mixed; boundary="===============5366344613872067940=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5366344613872067940==
Content-Type: multipart/alternative; 
	boundary="=_fedc12fe-9489-44d5-81b6-2906f2ebede0"

--=_fedc12fe-9489-44d5-81b6-2906f2ebede0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Can you try:=20

- Reproducing with a more recent LTTng-UST/LTTng-Tools ? (e.g. 2.13). LTTng=
 2.7 is not supported anymore.=20
- Try to reproduce with "per-pid" UST buffers rather than "per-uid",=20
- Try to reproduce without the "tracefile rotation" mode (without --tracefi=
le-count and --tracefile-size options to the channel).=20

Also, do you happen to have traced applications which are frequently killed=
 asynchronously=20
while some of their threads are actively tracing by any chance ?=20

Thanks,=20

Mathieu=20

----- On Dec 7, 2021, at 4:03 AM, lttng-dev <lttng-dev@lists.lttng.org> wro=
te:=20

> Hi, Lttng-dev:

> I found a strange problem related to lttng-consumed and ctf files recentl=
y. The
> ctf files belongs to some CPUs have been stopped rotating but other ctf
> files(belong to other CPUs) keeped working as usual. I am very sure all C=
PUs
> were producing spans all the time.

> #date; ls -ltrh channel0_0_* |tail -n 3; date;ls -ltrh channel0_1_* |tail=
 -n 3
> Tue Dec 7 16:25:45 CST 2021
> -rw-rw---- 1 root root 1.8M Dec 7 16:20 channel0_0_17
> -rw-rw---- 1 root root 2.0M Dec 7 16:23 channel0_0_18
> -rw-rw---- 1 root root 916K Dec 7 16:24 channel0_0_19
> Tue Dec 7 16:25:45 CST 2021
> -rw-rw---- 1 root root 1.7M Dec 6 00:30 channel0_1_8
> -rw-rw---- 1 root root 1.9M Dec 6 00:31 channel0_1_9
> -rw-rw---- 1 root root 388K Dec 6 00:32 channel0_1_10

> Notice that the ctf files with CPU0 (channel0_0_19) was modified at the t=
ime
> "now", but the ctf files with CPU1(channeo0_1_10) has been stopped workin=
g at
> Dec 6.
> I gdb lttng-consumerd=EF=BC=88break at lib_ring_buffer_channel_do_read() =
and
> lib_ring_buffer_poll_deliver()--I configured a read timer on channels). S=
ee the
> followings ( lib_ring_buffer_poll_deliver() )

> 0x00007f0f2418a445 <+213>: mov 0x0(%r13),%rcx rcx:0x7f0f0402e610(handle->=
table)
> 0x00007f0f2418a449 <+217>: mov 0x98(%rsi),%r9 rsi:0x7f0efb86f000(buf)
> r9:0x86c400000(consumed_old =3D buf->consumed)
> 0x00007f0f2418a450 <+224>: lea 0x150(%rsi),%rdi rdi:0x7f0efda75150
> 0x00007f0f2418a457 <+231>: mov 0x150(%rsi),%rax rax:3(cpu?)
> 0x00007f0f2418a45e <+238>: mov 0x78(%rbp),%rdx rbp:chan
> rdx:0x1000000(chan->backend.buf_size)
> 0x00007f0f2418a462 <+242>: mov 0x88(%rbp),%r8d
> r8d:0x14(20)(chan->backend.buf_size_order)
> 0x00007f0f2418a469 <+249>: cmp %rax,0x8(%rcx)
> 0x00007f0f2418a46d <+253>: jbe 0x7f0f2418a80c
> <lib_ring_buffer_channel_do_read+1180>
> 0x00007f0f2418a473 <+259>: shl $0x6,%rax rax:192
> 0x00007f0f2418a477 <+263>: sub $0x1,%rdx rdx:0xffffff 16777215
> (chan->backend.buf_size - 1)
> 0x00007f0f2418a47b <+267>: lea 0x10(%rax,%rcx,1),%r10 rax:192
> rcx:0x7f0f0402e610(handle->table) r10:0x7f0f0402e6e0
> 0x00007f0f2418a480 <+272>: and %r9,%rdx r9:0x8fdc00000 rdx:0xc00000 12582=
912
> buf_trunc(consume_old, chan->backend.buf_size - 1)
> 0x00007f0f2418a483 <+275>: mov 0x8(%rdi),%rax rdi:0x7f0efda75150 rax:2688
> ref_offset =3D (size_t) ref->offset
> 0x00007f0f2418a487 <+279>: mov %r8d,%ecx ecx:0x14(20)
> 0x00007f0f2418a48a <+282>: shr %cl,%rdx (....)
> 0x00007f0f2418a48d <+285>: shl $0x7,%rdx
> 0x00007f0f2418a491 <+289>: add %rax,%rdx
> 0x00007f0f2418a494 <+292>: lea 0x80(%rdx),%rax
> 0x00007f0f2418a49b <+299>: cmp 0x28(%r10),%rax
> 0x00007f0f2418a49f <+303>: ja 0x7f0f2418a80c
> <lib_ring_buffer_channel_do_read+1180>
> 0x00007f0f2418a4a5 <+309>: mov 0x20(%r10),%rax r10:0x7f0f0402e6e0
> rax:0x7f0efb86f000(buf)
> 0x00007f0f2418a4a9 <+313>: add %rdx,%rax rdx:3200 rax:0x7f0efb86fc80
> 0x00007f0f2418a4ac <+316>: mov (%rax),%rax
> rax:0x86c00000(commit_count!!!!!!Incremented _once_ at sb switch cc_sb)
> 0x00007f0f2418a4af <+319>: mov 0x80(%rbp),%r8
> r8:0x100000(chan->backend.subbuf_size)
> 0x00007f0f2418a4b6 <+326>: mov 0x78(%rbp),%rdx
> rdx:0x1000000(chan->backend.buf_size)
> 0x00007f0f2418a4ba <+330>: mov 0x8c(%rbp),%ecx ecx:4
> 0x00007f0f2418a4c0 <+336>: mov 0x80(%rsi),%rdi rdi:0x86d400000
> 0x00007f0f2418a4c7 <+343>: sub %r8,%rax rax:0x86b00000(commit_count -
> chan->backend.subbuf_size)
> 0x00007f0f2418a4ca <+346>: and 0x8(%rbp),%rax rax & chan->commit_count_ma=
sk =3D
> rax:0x86b00000
> 0x00007f0f2418a4ce <+350>: neg %rdx rdx:0x1000000(16M chan->backend.buf_s=
ize)
> --> 0xffffffffff000000(-16777216)
> 0x00007f0f2418a4d1 <+353>: and %r9,%rdx r9:0x86c400000(consume_old)
> rdx:0x86c000000
> 0x00007f0f2418a4d4 <+356>: shr %cl,%rdx cl:4 rdx:0x86c00000
> 0x00007f0f2418a4d7 <+359>: cmp %rdx,%rax rax:0x86b0000 rdx:0x86c00000
> 0x00007f0f2418a4da <+362>: jne 0x7f0f2418a411
> <lib_ring_buffer_channel_do_read+161>
> 0x00007f0f2418a4e0 <+368>: mov %r8,%rax
> 209 static inline
> 210 int lib_ring_buffer_poll_deliver(const struct
> lttng_ust_lib_ring_buffer_config *config,
> 211 struct lttng_ust_lib_ring_buffer *buf,
> 212 struct channel *chan,
> 213 struct lttng_ust_shm_handle *handle)
> 214 {
> 215 unsigned long consumed_old, consumed_idx, commit_count, write_offset;
> 216
> 217 consumed_old =3D uatomic_read(&buf->consumed);
> 218 consumed_idx =3D subbuf_index(consumed_old, chan);
> 219 commit_count =3D v_read(config, &shmp_index(handle, buf->commit_cold,
> consumed_idx)->cc_sb);
> 220 /*
> 221 * No memory barrier here, since we are only interested
> 222 * in a statistically correct polling result. The next poll will
> 223 * get the data is we are racing. The mb() that ensures correct
> 224 * memory order is in get_subbuf.
> 225 */
> 226 write_offset =3D v_read(config, &buf->offset);
> 227
> 228 /*
> 229 * Check that the subbuffer we are trying to consume has been
> 230 * already fully committed.
> 231 */
> 232
> 233 if (((commit_count - chan->backend.subbuf_size)
> 234 & chan->commit_count_mask)
> 235 - (buf_trunc(consumed_old, chan)
> 236 >> chan->backend.num_subbuf_order)
> 237 !=3D 0)
> 238 return 0;
> 239
> 240 /*
> 241 * Check that we are not about to read the same subbuffer in
> 242 * which the writer head is.
> 243 */
> 244 if (subbuf_trunc(write_offset, chan) - subbuf_trunc(consumed_old, cha=
n)
> 245 =3D=3D 0)
> 246 return 0;
> 247
> 248 return 1;
> 249
> 250 }

> It seems that lib_ring_buffer_channel_do_read()-> lib_ring_buffer_poll_de=
liver()
> returned 0 at line 238 ($consume_old:0x86c400000, $commint_count:0x86c000=
00,
> $write_offset:0x86d400000).

> Buffer type: per UID
> Channels:
> -------------
> - channel0: [enabled]

> Attributes:
> overwrite mode: 0
> subbufers size: 1048576
> number of subbufers: 16
> switch timer interval: 20000000
> read timer interval: 60000000
> trace file count: 80
> trace file size (bytes): 2097152
> output: mmap()

> PS: Lttng version is 2.7(I know it is an very old version:) )
> Do you have any ideas about this problem? Thanks in advance

> Thanks a lot
> zhenyu.ren

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_fedc12fe-9489-44d5-81b6-2906f2ebede0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>Can you try:<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div>- Reproducing with a more recent L=
TTng-UST/LTTng-Tools ? (e.g. 2.13). LTTng 2.7 is not supported anymore.<br =
data-mce-bogus=3D"1"></div><div>- Try to reproduce with "per-pid" UST buffe=
rs rather than "per-uid",<br data-mce-bogus=3D"1"></div><div>- Try to repro=
duce without the "tracefile rotation" mode (without --tracefile-count and -=
-tracefile-size options to the channel).<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Also, do you happen to have traced app=
lications which are frequently killed asynchronously<br data-mce-bogus=3D"1=
"></div><div>while some of their threads are actively tracing by any chance=
 ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>T=
hanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><div><span id=3D"zwchr" data-marker=
=3D"__DIVIDER__">----- On Dec 7, 2021, at 4:03 AM, lttng-dev &lt;lttng-dev@=
lists.lttng.org&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEX=
T__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=
=3D"__aliyun_email_body_block"><div><span style=3D"font-family:'tahoma' , '=
arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">Hi, Lttng-dev:<=
/span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' =
, 'simsun';font-size:14px;color:#000000"><br></span></div><div><span style=
=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;co=
lor:#000000">&nbsp; I found a strange problem related to lttng-consumed and=
 ctf files recently. The ctf files belongs to some CPUs have been stopped r=
otating but other ctf files(belong to other CPUs) keeped working as usual. =
I am very sure all CPUs were producing spans all the time.</span></div><br>=
<div>#date;&nbsp;ls&nbsp;-ltrh&nbsp;channel0_0_*&nbsp;|tail&nbsp;-n&nbsp;3;=
&nbsp;date;ls&nbsp;-ltrh&nbsp;channel0_1_*&nbsp;|tail&nbsp;-n&nbsp;3<br>Tue=
&nbsp;Dec&nbsp;&nbsp;7&nbsp;16:25:45&nbsp;CST&nbsp;2021<br>-rw-rw----&nbsp;=
1&nbsp;root&nbsp;root&nbsp;1.8M&nbsp;Dec&nbsp;&nbsp;7&nbsp;16:20&nbsp;chann=
el0_0_17<br>-rw-rw----&nbsp;1&nbsp;root&nbsp;root&nbsp;2.0M&nbsp;Dec&nbsp;&=
nbsp;7&nbsp;16:23&nbsp;channel0_0_18<br>-rw-rw----&nbsp;1&nbsp;root&nbsp;ro=
ot&nbsp;916K&nbsp;Dec&nbsp;&nbsp;7&nbsp;16:24&nbsp;channel0_0_19<br>Tue&nbs=
p;Dec&nbsp;&nbsp;7&nbsp;16:25:45&nbsp;CST&nbsp;2021<br>-rw-rw----&nbsp;1&nb=
sp;root&nbsp;root&nbsp;1.7M&nbsp;Dec&nbsp;&nbsp;6&nbsp;00:30&nbsp;channel0_=
1_8<br>-rw-rw----&nbsp;1&nbsp;root&nbsp;root&nbsp;1.9M&nbsp;Dec&nbsp;&nbsp;=
6&nbsp;00:31&nbsp;channel0_1_9<br>-rw-rw----&nbsp;1&nbsp;root&nbsp;root&nbs=
p;388K&nbsp;Dec&nbsp;&nbsp;6&nbsp;00:32&nbsp;channel0_1_10</div><br><div>&n=
bsp; &nbsp; Notice that the ctf files with CPU0 (channel0_0_19) was modifie=
d at the time "now", but the ctf files with CPU1(channeo0_1_10) has been st=
opped working at Dec 6.</div><div>&nbsp; &nbsp; I gdb lttng-consumerd=EF=BC=
=88break at&nbsp;lib_ring_buffer_channel_do_read() and&nbsp; lib_ring_buffe=
r_poll_deliver()--I configured a read timer on channels). See the following=
s (<span style=3D"color:#000000;font-family:'tahoma' , 'arial' , 'stheiti' =
, 'simsun';font-size:14px;font-style:normal;font-weight:400;text-indent:0px=
;text-transform:none;background-color:#ffffff;float:none;display:inline">li=
b_ring_buffer_poll_deliver() )</span></div><br><div>&nbsp;&nbsp;&nbsp;0x000=
07f0f2418a445&nbsp;&lt;+213&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x0(%r13),=
%rcx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;rcx:0x7f0f0402e610(handle-&gt;table)<br>&nbsp;&nbs=
p;&nbsp;0x00007f0f2418a449&nbsp;&lt;+217&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nb=
sp;0x98(%rsi),%r9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rsi:0x7f0efb86f000(buf)&nbsp;r9:0x86c=
400000(consumed_old&nbsp;=3D&nbsp;buf-&gt;consumed)<br>&nbsp;&nbsp;&nbsp;0x=
00007f0f2418a450&nbsp;&lt;+224&gt;:&nbsp;lea&nbsp;&nbsp;&nbsp;&nbsp;0x150(%=
rsi),%rdi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;rdi:0x7f0efda75150<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a45=
7&nbsp;&lt;+231&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x150(%rsi),%rax&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;rax:3(cpu?)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a45e&nbsp;&lt;+238&gt;:&n=
bsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x78(%rbp),%rdx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rbp:chan&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rdx:0x1000000(chan-&gt;backend.buf_size)<br>&=
nbsp;&nbsp;&nbsp;0x00007f0f2418a462&nbsp;&lt;+242&gt;:&nbsp;mov&nbsp;&nbsp;=
&nbsp;&nbsp;0x88(%rbp),%r8d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r8d:0x14(20)(chan-&gt;backend.buf=
_size_order)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a469&nbsp;&lt;+249&gt;:&nbs=
p;cmp&nbsp;&nbsp;&nbsp;&nbsp;%rax,0x8(%rcx)<br>&nbsp;&nbsp;&nbsp;0x00007f0f=
2418a46d&nbsp;&lt;+253&gt;:&nbsp;jbe&nbsp;&nbsp;&nbsp;&nbsp;0x7f0f2418a80c&=
nbsp;&lt;lib_ring_buffer_channel_do_read+1180&gt;<br>&nbsp;&nbsp;&nbsp;0x00=
007f0f2418a473&nbsp;&lt;+259&gt;:&nbsp;shl&nbsp;&nbsp;&nbsp;&nbsp;$0x6,%rax=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rax:192<br>&nbsp;&nbsp;&=
nbsp;0x00007f0f2418a477&nbsp;&lt;+263&gt;:&nbsp;sub&nbsp;&nbsp;&nbsp;&nbsp;=
$0x1,%rdx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rdx:0xffffff&nb=
sp;16777215&nbsp;(chan-&gt;backend.buf_size&nbsp;-&nbsp;1)<br>&nbsp;&nbsp;&=
nbsp;0x00007f0f2418a47b&nbsp;&lt;+267&gt;:&nbsp;lea&nbsp;&nbsp;&nbsp;&nbsp;=
0x10(%rax,%rcx,1),%r10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rax:1=
92&nbsp;rcx:0x7f0f0402e610(handle-&gt;table)&nbsp;r10:0x7f0f0402e6e0<br>&nb=
sp;&nbsp;&nbsp;0x00007f0f2418a480&nbsp;&lt;+272&gt;:&nbsp;and&nbsp;&nbsp;&n=
bsp;&nbsp;%r9,%rdx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
r9:0x8fdc00000&nbsp;rdx:0xc00000&nbsp;12582912&nbsp;&nbsp;buf_trunc(consume=
_old,&nbsp;chan-&gt;backend.buf_size&nbsp;-&nbsp;1)<br>&nbsp;&nbsp;&nbsp;0x=
00007f0f2418a483&nbsp;&lt;+275&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x8(%rd=
i),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;rdi:0x7f0efda75150&nbsp;rax:2688&nbsp;ref_offse=
t&nbsp;=3D&nbsp;(size_t)&nbsp;ref-&gt;offset<br>&nbsp;&nbsp;&nbsp;0x00007f0=
f2418a487&nbsp;&lt;+279&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;%r8d,%ecx&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ecx:0x14(20)<br>&nbsp;&nbsp;&=
nbsp;0x00007f0f2418a48a&nbsp;&lt;+282&gt;:&nbsp;shr&nbsp;&nbsp;&nbsp;&nbsp;=
%cl,%rdx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;(....)&nbsp;<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a48d=
&nbsp;&lt;+285&gt;:&nbsp;shl&nbsp;&nbsp;&nbsp;&nbsp;$0x7,%rdx<br>&nbsp;&nbs=
p;&nbsp;0x00007f0f2418a491&nbsp;&lt;+289&gt;:&nbsp;add&nbsp;&nbsp;&nbsp;&nb=
sp;%rax,%rdx<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a494&nbsp;&lt;+292&gt;:&nbs=
p;lea&nbsp;&nbsp;&nbsp;&nbsp;0x80(%rdx),%rax<br>&nbsp;&nbsp;&nbsp;0x00007f0=
f2418a49b&nbsp;&lt;+299&gt;:&nbsp;cmp&nbsp;&nbsp;&nbsp;&nbsp;0x28(%r10),%ra=
x<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a49f&nbsp;&lt;+303&gt;:&nbsp;ja&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;0x7f0f2418a80c&nbsp;&lt;lib_ring_buffer_channel_do_r=
ead+1180&gt;<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4a5&nbsp;&lt;+309&gt;:&nbs=
p;mov&nbsp;&nbsp;&nbsp;&nbsp;0x20(%r10),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r10:0x7f0f0402e6=
e0&nbsp;rax:0x7f0efb86f000(buf)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4a9&nbs=
p;&lt;+313&gt;:&nbsp;add&nbsp;&nbsp;&nbsp;&nbsp;%rdx,%rax&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rdx:3200&nbsp;&nbsp;rax:0x7f0efb86fc80<br>=
&nbsp;&nbsp;&nbsp;0x00007f0f2418a4ac&nbsp;&lt;+316&gt;:&nbsp;mov&nbsp;&nbsp=
;&nbsp;&nbsp;(%rax),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rax:0x86c000=
00(commit_count!!!!!!Incremented&nbsp;_once_&nbsp;at&nbsp;sb&nbsp;switch&nb=
sp;cc_sb)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4af&nbsp;&lt;+319&gt;:&nbsp;m=
ov&nbsp;&nbsp;&nbsp;&nbsp;0x80(%rbp),%r8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r8:0x100000(ch=
an-&gt;backend.subbuf_size)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4b6&nbsp;&l=
t;+326&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x78(%rbp),%rdx&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r=
dx:0x1000000(chan-&gt;backend.buf_size)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418=
a4ba&nbsp;&lt;+330&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x8c(%rbp),%ecx&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;ecx:4<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4c0&nbsp;&lt;+336&gt;:=
&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0x80(%rsi),%rdi&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rdi:0x86d400=
000<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4c7&nbsp;&lt;+343&gt;:&nbsp;sub&nbs=
p;&nbsp;&nbsp;&nbsp;%r8,%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;rax:0x86b00000(commit_count&nbsp;-&nbsp;chan-&gt;backend.subbuf_s=
ize)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4ca&nbsp;&lt;+346&gt;:&nbsp;and&nb=
sp;&nbsp;&nbsp;&nbsp;0x8(%rbp),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rax&nbsp;&amp;&nbsp=
;chan-&gt;commit_count_mask&nbsp;=3D&nbsp;rax:0x86b00000<br>&nbsp;&nbsp;&nb=
sp;0x00007f0f2418a4ce&nbsp;&lt;+350&gt;:&nbsp;neg&nbsp;&nbsp;&nbsp;&nbsp;%r=
dx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;rdx:0x1000000(16M&nbsp;chan-&gt;backend.buf_size)&nbsp;&nbsp;--&gt;=
&nbsp;0xffffffffff000000(-16777216)<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4d1=
&nbsp;&lt;+353&gt;:&nbsp;and&nbsp;&nbsp;&nbsp;&nbsp;%r9,%rdx&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r9:0x86c400000(consume_old)&nbsp;=
&nbsp;&nbsp;rdx:0x86c000000<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4d4&nbsp;&l=
t;+356&gt;:&nbsp;shr&nbsp;&nbsp;&nbsp;&nbsp;%cl,%rdx&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cl:4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rdx:0x86c00000<br>&nbsp;&nbsp;&=
nbsp;0x00007f0f2418a4d7&nbsp;&lt;+359&gt;:&nbsp;cmp&nbsp;&nbsp;&nbsp;&nbsp;=
%rdx,%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rax:0x86b0000&n=
bsp;rdx:0x86c00000<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4da&nbsp;&lt;+362&gt=
;:&nbsp;jne&nbsp;&nbsp;&nbsp;&nbsp;0x7f0f2418a411&nbsp;&lt;lib_ring_buffer_=
channel_do_read+161&gt;<br>&nbsp;&nbsp;&nbsp;0x00007f0f2418a4e0&nbsp;&lt;+3=
68&gt;:&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;%r8,%rax</div><div>&nbsp; &nbsp;</d=
iv><div>209&nbsp;static&nbsp;inline<br>210&nbsp;int&nbsp;lib_ring_buffer_po=
ll_deliver(const&nbsp;struct&nbsp;lttng_ust_lib_ring_buffer_config&nbsp;*co=
nfig,<br>211&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct&nbsp;lttng_ust_lib_ring=
_buffer&nbsp;*buf,<br>212&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;struct&nbsp;channel&nbsp;*chan,<br>213&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;struct&nbsp;lttng_ust_shm_handle&nbsp;*handle)<br>214&nbsp;{<!-- --><br>=
215&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned&nbsp;long&nbsp;consumed_old,&nbsp=
;consumed_idx,&nbsp;commit_count,&nbsp;write_offset;<br>216&nbsp;<br>217&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;consumed_old&nbsp;=3D&nbsp;uatomic_read(&amp;buf=
-&gt;consumed);<br>218&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;consumed_idx&nbsp;=3D&n=
bsp;subbuf_index(consumed_old,&nbsp;chan);<br>219&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;commit_count&nbsp;=3D&nbsp;v_read(config,&nbsp;&amp;shmp_index(handle,&=
nbsp;buf-&gt;commit_cold,&nbsp;consumed_idx)-&gt;cc_sb);<br>220&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;/*<br>221&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;No&nb=
sp;memory&nbsp;barrier&nbsp;here,&nbsp;since&nbsp;we&nbsp;are&nbsp;only&nbs=
p;interested<br>222&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;in&nbsp;a&nbs=
p;statistically&nbsp;correct&nbsp;polling&nbsp;result.&nbsp;The&nbsp;next&n=
bsp;poll&nbsp;will<br>223&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;get&nbs=
p;the&nbsp;data&nbsp;is&nbsp;we&nbsp;are&nbsp;racing.&nbsp;The&nbsp;mb()&nb=
sp;that&nbsp;ensures&nbsp;correct<br>224&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;*&nbsp;memory&nbsp;order&nbsp;is&nbsp;in&nbsp;get_subbuf.<br>225&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>226&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;write_offs=
et&nbsp;=3D&nbsp;v_read(config,&nbsp;&amp;buf-&gt;offset);<br>227&nbsp;<br>=
228&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>229&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;*&nbsp;Check&nbsp;that&nbsp;the&nbsp;subbuffer&nbsp;we&nbsp;are&nbsp;try=
ing&nbsp;to&nbsp;consume&nbsp;has&nbsp;been<br>230&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;*&nbsp;already&nbsp;fully&nbsp;committed.<br>231&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;*/<br>232&nbsp;<br>233&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&=
nbsp;(((commit_count&nbsp;-&nbsp;chan-&gt;backend.subbuf_size)<br>234&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;&nbsp;chan-&gt;c=
ommit_count_mask)<br>235&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;-&nbsp;(buf_trunc(consumed_old,&nbsp;chan)<br>236&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;&nbsp;chan-&gt;bac=
kend.num_subbuf_order)<br>237&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;!=3D&nbsp;0)<br>238&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;return&nbsp;0;<br>239&nbsp;<br>240&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br=
>241&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;Check&nbsp;that&nbsp;we&nbsp=
;are&nbsp;not&nbsp;about&nbsp;to&nbsp;read&nbsp;the&nbsp;same&nbsp;subbuffe=
r&nbsp;in<br>242&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;which&nbsp;the&n=
bsp;writer&nbsp;head&nbsp;is.<br>243&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<=
br>244&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;(subbuf_trunc(write_offset,&nbs=
p;chan)&nbsp;-&nbsp;subbuf_trunc(consumed_old,&nbsp;chan)<br>245&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D&nbsp;0)<br>246&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;0;<br>247&nbsp;<br>2=
48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;1;<br>249&nbsp;<br>250&nbsp;}</=
div><br><div>&nbsp; &nbsp; &nbsp; It seems that&nbsp;lib_ring_buffer_channe=
l_do_read()-&gt;<span style=3D"color:#000000;font-family:'tahoma' , 'arial'=
 , 'stheiti' , 'simsun';font-size:14px;font-style:normal;font-weight:400;te=
xt-indent:0px;text-transform:none;background-color:#ffffff;float:none;displ=
ay:inline">lib_ring_buffer_poll_deliver() returned 0 at line 238 ($consume_=
old:0x86c400000, $commint_count:0x86c00000, $write_offset:0x86d400000).</sp=
an></div><div><span style=3D"color:#000000;font-family:'tahoma' , 'arial' ,=
 'stheiti' , 'simsun';font-size:14px;font-style:normal;font-weight:400;text=
-indent:0px;text-transform:none;background-color:#ffffff;float:none;display=
:inline"><br></span></div><div><span style=3D"color:#000000;font-family:'ta=
homa' , 'arial' , 'stheiti' , 'simsun';font-size:14px;font-style:normal;fon=
t-weight:400;text-indent:0px;text-transform:none;background-color:#ffffff;f=
loat:none;display:inline">Buffer&nbsp;type:&nbsp;per&nbsp;UID<br>Channels:<=
br>-------------<br>-&nbsp;channel0:&nbsp;[enabled]<br><br>&nbsp;&nbsp;&nbs=
p;&nbsp;Attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;overwrite&nbsp;m=
ode:&nbsp;0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subbufers&nbsp;size:&nbs=
p;1048576<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;number&nbsp;of&nbsp;subbuf=
ers:&nbsp;16<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch&nbsp;timer&nbsp;=
interval:&nbsp;20000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read&nbsp;ti=
mer&nbsp;interval:&nbsp;60000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tra=
ce&nbsp;file&nbsp;count:&nbsp;80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tra=
ce&nbsp;file&nbsp;size&nbsp;(bytes):&nbsp;2097152<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;output:&nbsp;mmap()</span></div><div><span style=3D"color:#00=
0000;font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;f=
ont-style:normal;font-weight:400;text-indent:0px;text-transform:none;backgr=
ound-color:#ffffff;float:none;display:inline"><br></span></div><div><span s=
tyle=3D"color:#000000;font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun'=
;font-size:14px;font-style:normal;font-weight:400;text-indent:0px;text-tran=
sform:none;background-color:#ffffff;float:none;display:inline">&nbsp; &nbsp=
; &nbsp;PS: Lttng version is 2.7(I know it is an very old version:) )</span=
></div><div><span style=3D"color:#000000;font-family:'tahoma' , 'arial' , '=
stheiti' , 'simsun';font-size:14px;font-style:normal;font-weight:400;text-i=
ndent:0px;text-transform:none;background-color:#ffffff;float:none;display:i=
nline">&nbsp; &nbsp; &nbsp;Do you have any ideas about this problem? Thanks=
 in advance</span></div><div><span style=3D"color:#000000;font-family:'taho=
ma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;font-style:normal;font-=
weight:400;text-indent:0px;text-transform:none;background-color:#ffffff;flo=
at:none;display:inline"><br></span></div><div><span style=3D"color:#000000;=
font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;font-s=
tyle:normal;font-weight:400;text-indent:0px;text-transform:none;background-=
color:#ffffff;float:none;display:inline">Thanks a lot</span></div><div><spa=
n style=3D"color:#000000;font-family:'tahoma' , 'arial' , 'stheiti' , 'sims=
un';font-size:14px;font-style:normal;font-weight:400;text-indent:0px;text-t=
ransform:none;background-color:#ffffff;float:none;display:inline">zhenyu.re=
n</span></div></div><br>_______________________________________________<br>=
lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div=
><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>E=
fficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_fedc12fe-9489-44d5-81b6-2906f2ebede0--

--===============5366344613872067940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5366344613872067940==--
