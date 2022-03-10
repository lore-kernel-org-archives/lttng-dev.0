Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA64FC43219
	for <lttng-dev@archiver.kernel.org>; Thu, 10 Mar 2022 14:31:48 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KDs2V5DFtzBnB;
	Thu, 10 Mar 2022 09:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646922707;
	bh=7ZbFN7LNRzDr7mmTw7lE6PZ5U25XyQbPKh3pO8TVTh4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Jbqdz170miBM5Z9RYJxNwYnXWr+8oJADr+OuSWolykn40MOXaynjZQ8pfuK0KoT4r
	 39swwCRafkDZaGRE8Smm0PRobCLEtFZMwdS56qRMuHN1u8Wp8kJmW+NIAzMhEheqVX
	 k3qwGBlYWenioXZDn+XCv0200ar89fI9KlIptBWSGYDgoEfxWXhr1wHLEHi9qT7GZK
	 hTFPxFoPF6OBkdmnUoewWvxT8+dqkaLsnNl8lXHH96PrFlKlKJ9sYSuOKSiaRPQCyq
	 Sep7bE1YeGSCNFijcU7ojjQsYIB102/CqP3uyNLtdcK3alIQ/YU5bQMVY8uG46wiDB
	 /ZBBujljZqHwQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KDs2T12lfzBmy
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2022 09:31:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A2D8639F6B1
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2022 09:31:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id VmFyXIV4inl7; Thu, 10 Mar 2022 09:31:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 97C5D39F2FB;
 Thu, 10 Mar 2022 09:31:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 97C5D39F2FB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id JA6gJLt0Ctpx; Thu, 10 Mar 2022 09:31:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8621339F34F;
 Thu, 10 Mar 2022 09:31:37 -0500 (EST)
Date: Thu, 10 Mar 2022 09:31:37 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <955901820.138250.1646922697445.JavaMail.zimbra@efficios.com>
In-Reply-To: <401d796b-8f3c-453f-82f3-bf79e01a25d5.zhenyu.ren@aliyun.com>
References: <e706d6c8-edea-4f26-a9e2-4a66f067204e.zhenyu.ren@aliyun.com>
 <20220225142111.GC1861057@x>
 <26341add-b962-4027-8c5e-28d940e8f4dc.zhenyu.ren@aliyun.com>
 <2119663162.129405.1646752637020.JavaMail.zimbra@efficios.com>
 <1a87b3ee-9983-4db6-b569-e6e6c1ab8411.zhenyu.ren@aliyun.com>
 <816104861.134170.1646843822208.JavaMail.zimbra@efficios.com>
 <ed737790-a420-4c5b-9245-edecd819c43b.zhenyu.ren@aliyun.com>
 <401d796b-8f3c-453f-82f3-bf79e01a25d5.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: =?utf-8?B?5Zue5aSN77yaW2x0dG5nLWRldl0g5Zue5aSN77ya5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJog5Zue5aSN77ya?=
 shm leak in traced application?
Thread-Index: uNO72bCd8r28WqIxmguGR40bPARrWA==
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8muWbnuWkje+8miA=?=
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJogc2htIGxlYWsgaW4gdHJh?=
 =?utf-8?q?ced_application=3F?=
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/mixed; boundary="===============8356484169375359530=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8356484169375359530==
Content-Type: multipart/alternative; 
	boundary="=_16bd5163-5882-4279-83e8-efe4a14e4cbe"

--=_16bd5163-5882-4279-83e8-efe4a14e4cbe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zhenyu,=20

This is exactly why Jonathan and I asked you to fill a bug report on the bu=
g tracker=20
and follow the bug reporting guidelines ( [ https://lttng.org/community/#bu=
g-reporting-guidelines | https://lttng.org/community/#bug-reporting-guideli=
nes ] ).=20

This saves time for everyone.=20

Thanks,=20

Mathieu=20

----- On Mar 9, 2022, at 11:24 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote=
:=20

> Oh, I see. I have an old ust(2.7). So I have no FD_CLOEXEC in
> ustcomm_recv_fds_unix_sock().

> Thanks very much!!!
> zhenyu.ren

>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng-dev@=
lists.lttng.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=8810=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 11:24
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers=
@efficios.com>
>> =E6=8A=84 =E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>
>> =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A=E5=
=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=
=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?

>>> When this happpens, is the process holding a single (or very few) shm f=
ile
>> > references, or references to many shm files ?

>> It is holding "all" of shm files' reference , neither a single one nor s=
ome few
>> ones.

>> In fact, yesterday, I tried to fix it as the following and it seems work=
.

>> --- a/lttng-ust/libringbuffer/shm.c

>> +++ b/lttng-ust/libringbuffer/shm.c

>> @@ -32,7 +32,6 @@

>> #include <lttng/align.h>

>> #include <limits.h>

>> #include <helper.h>

>> -

>> /*

>> * Ensure we have the required amount of space available by writing 0

>> * into the entire buffer. Not doing so can trigger SIGBUS when going

>> @@ -122,6 +121,12 @@ struct shm_object *_shm_object_table_alloc_shm(stru=
ct
>> shm_object_table *table,

>> /* create shm */

>> shmfd =3D stream_fd;

>> + if (shmfd >=3D 0) {

>> + ret =3D fcntl(shmfd, F_SETFD, FD_CLOEXEC);

>> + if (ret < 0) {

>> + PERROR("fcntl shmfd FD_CLOEXEC");

>> + }

>> + }

>> ret =3D zero_file(shmfd, memory_map_size);

>> if (ret) {

>> PERROR("zero_file");

>> @@ -272,15 +277,22 @@ struct shm_object *shm_object_table_append_shm(str=
uct
>> shm_object_table *table,

>> obj->shm_fd =3D shm_fd;

>> obj->shm_fd_ownership =3D 1;

>> + if (shm_fd >=3D 0) {

>> + ret =3D fcntl(shm_fd, F_SETFD, FD_CLOEXEC);

>> + if (ret < 0) {

>> + PERROR("fcntl shmfd FD_CLOEXEC");

>> + //goto error_fcntl;

>> + }

>> + }

>> ret =3D fcntl(obj->wait_fd[1], F_SETFD, FD_CLOEXEC);

>> if (ret < 0) {

>> As it shows, wait_fd[1] has been set FD_CLOEXEC by fcntl() but not shm_f=
d. Why
>> your patch do with wait_fd but not shm_fd? As far as I know, wait_fd is =
just a
>> pipe and it seems not related to shm resource.

>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers=
@efficios.com>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=8810=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 00:46
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
>> =E6=8A=84 =E9=80=81=EF=BC=9AJonathan Rajotte <jonathan.rajotte-julien@ef=
ficios.com>; lttng-dev
>> <lttng-dev@lists.lttng.org>
>> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: =E5=9B=9E=E5=A4=8D=EF=BC=9A[lttng-dev] =
=E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=
=EF=BC=9A shm leak in traced application?

>> When this happpens, is the process holding a single (or very few) shm fi=
le
>> references, or references to many
>> shm files ?

>> I wonder if you end up in a scenario where an application very frequentl=
y
>> performs exec(), and therefore
>> sometimes the exec() will happen in the window between the unix socket f=
ile
>> descriptor reception and
>> call to fcntl FD_CLOEXEC.

>> Thanks,

>> Mathieu

>> ----- On Mar 8, 2022, at 8:29 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wro=
te:
>> Thanks a lot for reply. I do not reply it in bug tracker since I have no=
t gotten
>> a reliable way to reproduce the leak case.
>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers=
@efficios.com>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=888=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:26
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
>> =E6=8A=84 =E9=80=81=EF=BC=9AJonathan Rajotte <jonathan.rajotte-julien@ef=
ficios.com>; lttng-dev
>> <lttng-dev@lists.lttng.org>
>> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A =
=E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced =
application?

>> ----- On Mar 8, 2022, at 12:18 AM, lttng-dev lttng-dev@lists.lttng.org w=
rote:

>> > Hi,
>> > In shm_object_table_append_shm()/alloc_shm()=EF=BC=8C why not calling =
FD_CLOEXEC fcntl()
>> > to shmfds? I guess this omission leads to shm fds leak.

>> Those file descriptors are created when received by ustcomm_recv_fds_uni=
x_sock,
>> and
>> immediately after creation they are set as FD_CLOEXEC.

>> We should continue this discussion in the bug tracker as suggested by Jo=
nathan.
>> It would greatly help if you can provide a small reproducer.

>> Thanks,

>> Mathieu

>> > Thanks
>> > zhenyu.ren

>> >> ------------------------------------------------------------------
>> >> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJonathan Rajotte-Julien <jonathan=
.rajotte-julien@efficios.com>
>> >> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=882=
5=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 22:31
>> >> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com=
>
>> >> =E6=8A=84 =E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>
>> >> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=
=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?

>> >> Hi zhenyu.ren,

>> >> Please open a bug on our bug tracker and provide a reproducer against=
 the latest
>> >> stable version (2.13.x).

>> >> [ https://bugs.lttng.org/ | https://bugs.lttng.org/ ]

>>>> Please follow the guidelines: [ https://bugs.lttng.org/#Bug-reporting-=
guidelines
>> >> | https://bugs.lttng.org/#Bug-reporting-guidelines ]

>> >> Cheers

>> >> On Fri, Feb 25, 2022 at 12:47:34PM +0800, zhenyu.ren via lttng-dev wr=
ote:
>> >> > Hi, lttng-dev team
>> >>> When lttng-sessiond exits, the ust applications should call
>> >>> lttng_ust_objd_table_owner_cleanup() and clean up all shm resource(u=
nmap and
>> >>> close). Howerver I do find that the ust applications keep opening "a=
ll" of the
>> >> > shm fds("/dev/shm/ust-shm-consumer-81132 (deleted)") and do NOT fre=
e shm.
>> >>> If we run lttng-sessiond again, ust applications can get a new piece=
 of shm and
>> >>> a new list of shm fds so double shm usages. Then if we kill lttng-se=
ssiond,
>> >>> what the mostlikely happened is ust applications close the new list =
of shm fds
>> >>> and free new shm resource but keeping old shm still. In other word, =
we can not
>> >> > free this piece of shm unless we killing ust applications!!!
>> >>> So Is there any possilbe that ust applications failed calling
>> >>> lttng_ust_objd_table_owner_cleanup()? Do you have ever see this prob=
lem? Do you
>> >>> have any advice to free the shm without killling ust applications(I =
tried to
>> >> > dig into kernel shm_open and /dev/shm, but not found any ideas)?

>> >> > Thanks in advance
>> >> > zhenyu.ren

>> >> > ------------------------------------------------------------------
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng=
-dev@lists.lttng.org>
>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 23:09
>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttn=
g.org>
>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A=
 shm leak in traced application?

>> >>> >"I found these items also exist in a traced application which is a =
long-time
>> >> > >running daemon"
>> >> > Even if lttng-sessiond has been killed!!

>> >> > Thanks
>> >> > zhenyu.ren
>> >> > ------------------------------------------------------------------
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng=
-dev@lists.lttng.org>
>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 22:44
>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttn=
g.org>
>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] shm leak in traced applicat=
ion?

>> >> > Hi,
>> >>> There are many items such as "/dev/shm/ust-shm-consumer-81132 (delet=
ed)" exist
>> >>> in lttng-sessiond fd spaces. I know it is the result of shm_open() a=
nd
>> >> > shm_unlnik() in create_posix_shm().
>> >>> However, today, I found these items also exist in a traced applicati=
on which is
>> >>> a long-time running daemon. The most important thing I found is that=
 there
>> >> > seems no reliable way to release share memory.
>> >>> I tried to kill lttng-sessiond but not always release share memory. =
Sometimes I
>> >>> need to kill the traced application to free share memory....But it i=
s not a
>> >> > good idea to kill these applications.
>> >> > My questions are:
>> >>> 1. Is there any way to release share memory without killing any trac=
ed
>> >> > application?
>> >>> 2. Is it normal that many items such as "/dev/shm/ust-shm-consumer-8=
1132
>> >> > (deleted)" exist in the traced application?

>> >> > Thanks
>> >> > zhenyu.ren

>> >> > _______________________________________________
>> >> > lttng-dev mailing list
>> >> > lttng-dev@lists.lttng.org
>>>> > [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> >> --
>> >> Jonathan Rajotte-Julien
>> >> EfficiOS
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_16bd5163-5882-4279-83e8-efe4a14e4cbe
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Zhenyu,</div><div><br data-mce-bogus=3D"=
1"></div><div>This is exactly why Jonathan and I asked you to fill a bug re=
port on the bug tracker<br data-mce-bogus=3D"1"></div><div>and follow the b=
ug reporting guidelines (<a href=3D"https://lttng.org/community/#bug-report=
ing-guidelines">https://lttng.org/community/#bug-reporting-guidelines</a>).=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thi=
s saves time for everyone.<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br><=
/div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Mar 9, 20=
22, at 11:24 PM, zhenyu.ren &lt;zhenyu.ren@aliyun.com&gt; wrote:<br></span>=
</div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><div class=3D"__aliyun_email_body_block"><div><s=
pan style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-siz=
e:14px;color:#000000">Oh, I see. I have an old ust(2.7). So I have no FD_CL=
OEXEC in&nbsp;ustcomm_recv_fds_unix_sock().&nbsp;</span></div><div><span st=
yle=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px=
;color:#000000"><br></span></div><div><span style=3D"font-family:'tahoma' ,=
 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">Thanks very m=
uch!!!</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'st=
heiti' , 'simsun';font-size:14px;color:#000000">zhenyu.ren</span></div><blo=
ckquote style=3D"margin-right:0;margin-top:0;margin-bottom:0"><div><span st=
yle=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px=
;color:#000000">-----------------------------------------------------------=
-------</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 's=
theiti' , 'simsun';font-size:14px;color:#000000">=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=9Azhenyu.ren via lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</spa=
n></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 's=
imsun';font-size:14px;color:#000000">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=
=EF=BC=9A2022=E5=B9=B43=E6=9C=8810=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 11=
:24</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'sthei=
ti' , 'simsun';font-size:14px;color:#000000">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=
=BC=9AMathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</span></div>=
<div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';f=
ont-size:14px;color:#000000">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Alttng-dev =
&lt;lttng-dev@lists.lttng.org&gt;</span></div><div><span style=3D"font-fami=
ly:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A=
=E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=
=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?</span=
></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'si=
msun';font-size:14px;color:#000000"><br></span></div><div><span class=3D" _=
_aliyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti'=
 , 'simsun';font-size:14px;color:#000000">&gt;</span><span class=3D" __aliy=
un_node_has_color" style=3D"color:#000000;font-family:'arial' , 'helvetica'=
 , sans-serif;font-size:16px">When this happpens, is the process holding a =
single (or very few) shm file references, or references to many&nbsp;</span=
><span class=3D" __aliyun_node_has_color" style=3D"color:#000000;font-famil=
y:'arial' , 'helvetica' , sans-serif;font-size:16px">shm files ?</span></di=
v><div><span class=3D" __aliyun_node_has_color" style=3D"color:#000000;font=
-family:'arial' , 'helvetica' , sans-serif;font-size:16px"><br></span></div=
><div><span class=3D" __aliyun_node_has_color" style=3D"color:#000000;font-=
family:'arial' , 'helvetica' , sans-serif"><span style=3D"font-size:16px">I=
t is holding "all" of shm files' reference , neither a single one nor some =
few ones.</span></span></div><div><span class=3D" __aliyun_node_has_color" =
style=3D"color:#000000;font-family:'arial' , 'helvetica' , sans-serif"><spa=
n style=3D"font-size:16px"><br></span></span></div><div><span class=3D" __a=
liyun_node_has_color" style=3D"color:#000000;font-family:'arial' , 'helveti=
ca' , sans-serif"><span style=3D"font-size:16px">In fact, yesterday, I trie=
d to fix it as the following and it seems work.</span></span></div><div><sp=
an class=3D" __aliyun_node_has_color" style=3D"color:#000000;font-family:'a=
rial' , 'helvetica' , sans-serif"><span style=3D"font-size:16px"><br></span=
></span></div><div><p class=3D"p1 __aliyun_node_has_color __aliyun_node_has=
_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#fd8a35;backgroun=
d-color:#61181b"><span class=3D"s1"><b>--- a/lttng-ust/libringbuffer/shm.c<=
/b></span></p><p class=3D"p1 __aliyun_node_has_color __aliyun_node_has_bgco=
lor" style=3D"margin:0px;font:400 12px 'menlo';color:#fd8a35;background-col=
or:#61181b"><span class=3D"s1"><b>+++ b/lttng-ust/libringbuffer/shm.c</b></=
span></p><p class=3D"p2 __aliyun_node_has_color __aliyun_node_has_bgcolor" =
style=3D"margin:0px;font:400 12px 'menlo';color:#7ddad0;background-color:#6=
1181b"><span class=3D"s1">@@ -32,7 +32,6 @@</span></p><p class=3D"p3 __aliy=
un_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 1=
2px 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s1">&nbs=
p;#include &lt;lttng/align.h&gt;</span></p><p class=3D"p3 __aliyun_node_has=
_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo'=
;color:#ffffff;background-color:#61181b"><span class=3D"s1">&nbsp;#include =
&lt;limits.h&gt;</span></p><p class=3D"p3 __aliyun_node_has_color __aliyun_=
node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ffffff;b=
ackground-color:#61181b"><span class=3D"s1">&nbsp;#include &lt;helper.h&gt;=
</span></p><p class=3D"p4 __aliyun_node_has_color __aliyun_node_has_bgcolor=
" style=3D"margin:0px;font:400 12px 'menlo';color:#fc5870;background-color:=
#61181b"><span class=3D"s1">-</span></p><p class=3D"p3 __aliyun_node_has_co=
lor __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';co=
lor:#ffffff;background-color:#61181b"><span class=3D"s1">&nbsp;/*</span></p=
><p class=3D"p3 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D=
"margin:0px;font:400 12px 'menlo';color:#ffffff;background-color:#61181b"><=
span class=3D"s1">&nbsp; * Ensure we have the required amount of space avai=
lable by writing 0</span></p><p class=3D"p3 __aliyun_node_has_color __aliyu=
n_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ffffff=
;background-color:#61181b"><span class=3D"s1">&nbsp; * into the entire buff=
er. Not doing so can trigger SIGBUS when going</span></p><p class=3D"p3 __a=
liyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:40=
0 12px 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s2 __=
aliyun_node_has_color" style=3D"color:#7ddad0">@@ -122,6 +121,12 @@</span><=
span class=3D"s1"> struct shm_object *_shm_object_table_alloc_shm(struct sh=
m_object_table *table,</span></p><p class=3D"p3 __aliyun_node_has_color __a=
liyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ff=
ffff;background-color:#61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp; &nbs=
p; /* create shm */</span></p><p class=3D"p5 __aliyun_node_has_color __aliy=
un_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#fffff=
f;background-color:#61181b"><span class=3D"s1">&nbsp;</span></p><p class=3D=
"p3 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;=
font:400 12px 'menlo';color:#ffffff;background-color:#61181b"><span class=
=3D"s1">&nbsp; &nbsp; &nbsp; &nbsp; shmfd =3D stream_fd;</span></p><p class=
=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0=
px;font:400 12px 'menlo';color:#84de79;background-color:#61181b"><span clas=
s=3D"s1">+&nbsp; &nbsp; if (shmfd &gt;=3D 0) {<!-- --></span></p><p class=
=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0=
px;font:400 12px 'menlo';color:#84de79;background-color:#61181b"><span clas=
s=3D"s1">+</span><span class=3D"s3 __aliyun_node_has_color" style=3D"color:=
#ffffff"> &nbsp; &nbsp; &nbsp; </span><span class=3D"s1">&nbsp; &nbsp; ret =
=3D fcntl(shmfd, F_SETFD, FD_CLOEXEC);</span></p><p class=3D"p6 __aliyun_no=
de_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px '=
menlo';color:#84de79;background-color:#61181b"><span class=3D"s1">+</span><=
span class=3D"s3 __aliyun_node_has_color" style=3D"color:#ffffff"> &nbsp; &=
nbsp; &nbsp; </span><span class=3D"s1">&nbsp; &nbsp; if (ret &lt; 0) {<!-- =
--></span></p><p class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgco=
lor" style=3D"margin:0px;font:400 12px 'menlo';color:#84de79;background-col=
or:#61181b"><span class=3D"s1">+</span><span class=3D"s3 __aliyun_node_has_=
color" style=3D"color:#ffffff"> &nbsp; &nbsp; &nbsp; </span><span class=3D"=
s4 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"color:#fffff=
f;background-color:#c9173d">&nbsp; &nbsp; </span><span class=3D"s3 __aliyun=
_node_has_color" style=3D"color:#ffffff">&nbsp; &nbsp; </span><span class=
=3D"s1">PERROR("fcntl shmfd FD_CLOEXEC");</span></p><p class=3D"p3 __aliyun=
_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12p=
x 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s5 __aliyu=
n_node_has_color" style=3D"color:#84de79">+</span><span class=3D"s1"> &nbsp=
; &nbsp; &nbsp; </span><span class=3D"s5 __aliyun_node_has_color" style=3D"=
color:#84de79">&nbsp; &nbsp; }</span></p><p class=3D"p6 __aliyun_node_has_c=
olor __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';c=
olor:#84de79;background-color:#61181b"><span class=3D"s1">+&nbsp; &nbsp; }<=
/span></p><p class=3D"p3 __aliyun_node_has_color __aliyun_node_has_bgcolor"=
 style=3D"margin:0px;font:400 12px 'menlo';color:#ffffff;background-color:#=
61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp; &nbsp; ret =3D zero_file(sh=
mfd, memory_map_size);</span></p><p class=3D"p3 __aliyun_node_has_color __a=
liyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ff=
ffff;background-color:#61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp; &nbs=
p; if (ret) {<!-- --></span></p><p class=3D"p3 __aliyun_node_has_color __al=
iyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#fff=
fff;background-color:#61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; PERROR("zero_file");</span></p><p class=3D"p3=
 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;fon=
t:400 12px 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s=
2 __aliyun_node_has_color" style=3D"color:#7ddad0">@@ -272,15 +277,22 @@</s=
pan><span class=3D"s1"> struct shm_object *shm_object_table_append_shm(stru=
ct shm_object_table *table,</span></p><p class=3D"p3 __aliyun_node_has_colo=
r __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';colo=
r:#ffffff;background-color:#61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp;=
 &nbsp; obj-&gt;shm_fd =3D shm_fd;</span></p><p class=3D"p3 __aliyun_node_h=
as_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menl=
o';color:#ffffff;background-color:#61181b"><span class=3D"s1">&nbsp; &nbsp;=
 &nbsp; &nbsp; obj-&gt;shm_fd_ownership =3D 1;</span></p><p class=3D"p5 __a=
liyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:40=
0 12px 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s1">&=
nbsp;</span></p><p class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bg=
color" style=3D"margin:0px;font:400 12px 'menlo';color:#84de79;background-c=
olor:#61181b"><span class=3D"s1">+&nbsp; &nbsp; if (shm_fd &gt;=3D 0) {<!--=
 --></span></p><p class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgc=
olor" style=3D"margin:0px;font:400 12px 'menlo';color:#84de79;background-co=
lor:#61181b"><span class=3D"s1">+</span><span class=3D"s3 __aliyun_node_has=
_color" style=3D"color:#ffffff"> &nbsp; &nbsp; &nbsp; </span><span class=3D=
"s1">&nbsp; &nbsp; ret =3D fcntl(shm_fd, F_SETFD, FD_CLOEXEC);</span></p><p=
 class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"ma=
rgin:0px;font:400 12px 'menlo';color:#84de79;background-color:#61181b"><spa=
n class=3D"s1">+</span><span class=3D"s3 __aliyun_node_has_color" style=3D"=
color:#ffffff"> &nbsp; &nbsp; &nbsp; </span><span class=3D"s1">&nbsp; &nbsp=
; if (ret &lt; 0) {<!-- --></span></p><p class=3D"p6 __aliyun_node_has_colo=
r __aliyun_node_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';colo=
r:#84de79;background-color:#61181b"><span class=3D"s1">+</span><span class=
=3D"s3 __aliyun_node_has_color" style=3D"color:#ffffff"> &nbsp; &nbsp; &nbs=
p; </span><span class=3D"s4 __aliyun_node_has_color __aliyun_node_has_bgcol=
or" style=3D"color:#ffffff;background-color:#c9173d">&nbsp; &nbsp; </span><=
span class=3D"s3 __aliyun_node_has_color" style=3D"color:#ffffff">&nbsp; &n=
bsp; </span><span class=3D"s1">PERROR("fcntl shmfd FD_CLOEXEC");</span></p>=
<p class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgcolor" style=3D"=
margin:0px;font:400 12px 'menlo';color:#84de79;background-color:#61181b"><s=
pan class=3D"s1">+</span><span class=3D"s3 __aliyun_node_has_color" style=
=3D"color:#ffffff"> &nbsp; &nbsp; &nbsp; </span><span class=3D"s4 __aliyun_=
node_has_color __aliyun_node_has_bgcolor" style=3D"color:#ffffff;background=
-color:#c9173d">&nbsp; &nbsp; </span><span class=3D"s3 __aliyun_node_has_co=
lor" style=3D"color:#ffffff">&nbsp; &nbsp; </span><span class=3D"s1">//goto=
 error_fcntl;</span></p><p class=3D"p3 __aliyun_node_has_color __aliyun_nod=
e_has_bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ffffff;back=
ground-color:#61181b"><span class=3D"s5 __aliyun_node_has_color" style=3D"c=
olor:#84de79">+</span><span class=3D"s1"> &nbsp; &nbsp; &nbsp; </span><span=
 class=3D"s5 __aliyun_node_has_color" style=3D"color:#84de79">&nbsp; &nbsp;=
 }</span></p><p class=3D"p6 __aliyun_node_has_color __aliyun_node_has_bgcol=
or" style=3D"margin:0px;font:400 12px 'menlo';color:#84de79;background-colo=
r:#61181b"><span class=3D"s1">+&nbsp; &nbsp; }</span></p><p class=3D"p3 __a=
liyun_node_has_color __aliyun_node_has_bgcolor" style=3D"margin:0px;font:40=
0 12px 'menlo';color:#ffffff;background-color:#61181b"><span class=3D"s1">&=
nbsp; &nbsp; &nbsp; &nbsp; ret =3D fcntl(obj-&gt;wait_fd[1], F_SETFD, FD_CL=
OEXEC);</span></p><p class=3D"p3 __aliyun_node_has_color __aliyun_node_has_=
bgcolor" style=3D"margin:0px;font:400 12px 'menlo';color:#ffffff;background=
-color:#61181b"><span class=3D"s1">&nbsp; &nbsp; &nbsp; &nbsp; if (ret &lt;=
 0) {<!-- --></span></p></div><div><span class=3D" __aliyun_node_has_color"=
 style=3D"color:#000000;font-family:'arial' , 'helvetica' , sans-serif"><sp=
an style=3D"font-size:16px"><br></span></span></div><div><span class=3D" __=
aliyun_node_has_color" style=3D"color:#000000;font-family:'arial' , 'helvet=
ica' , sans-serif"><span style=3D"font-size:16px">&nbsp; &nbsp; As it shows=
, wait_fd[1] has been set FD_CLOEXEC by fcntl() but not shm_fd. Why your pa=
tch do with wait_fd but not shm_fd? As far as I know, wait_fd is just a pip=
e and it seems not related to shm resource.</span></span></div><br><div><sp=
an class=3D" __aliyun_node_has_color" style=3D"color:#000000;font-family:'a=
rial' , 'helvetica' , sans-serif"><span style=3D"font-size:16px"><br></span=
></span></div><div><span class=3D" __aliyun_node_has_color" style=3D"color:=
#000000;font-family:'arial' , 'helvetica' , sans-serif"><span style=3D"font=
-size:16px"><br></span></span></div><div><span class=3D" __aliyun_node_has_=
color" style=3D"color:#000000;font-family:'arial' , 'helvetica' , sans-seri=
f"><span style=3D"font-size:16px"><br></span></span></div><div><span class=
=3D" __aliyun_node_has_color" style=3D"color:#000000;font-family:'arial' , =
'helvetica' , sans-serif"><span style=3D"font-size:16px"><br></span></span>=
</div><div><span class=3D" __aliyun_node_has_color" style=3D"color:#000000;=
font-family:'arial' , 'helvetica' , sans-serif"><span style=3D"font-size:16=
px"><br></span></span></div><div><span class=3D" __aliyun_node_has_color" s=
tyle=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14p=
x;color:#000000">----------------------------------------------------------=
--------</span></div><div><span class=3D" __aliyun_node_has_color" style=3D=
"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color=
:#000000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers &lt;mathieu=
.desnoyers@efficios.com&gt;</span></div><div><span class=3D" __aliyun_node_=
has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';f=
ont-size:14px;color:#000000">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2=
022=E5=B9=B43=E6=9C=8810=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 00:46</span>=
</div><div><span class=3D" __aliyun_node_has_color" style=3D"font-family:'t=
ahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E6=
=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&gt;</=
span></div><div><span class=3D" __aliyun_node_has_color" style=3D"font-fami=
ly:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AJonathan Rajotte &lt;jonathan.rajotte-j=
ulien@efficios.com&gt;; lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</span><=
/div><div><span class=3D" __aliyun_node_has_color" style=3D"font-family:'ta=
homa' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E4=B8=
=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: =E5=9B=9E=E5=A4=8D=EF=BC=9A[lttng-dev] =
=E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=
=EF=BC=9A shm leak in traced application?</span></div><div><span class=3D" =
__aliyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti=
' , 'simsun';font-size:14px;color:#000000"><br></span></div><div class=3D" =
__aliyun_node_has_color __aliyun_node_has_color" style=3D"font-family:'aria=
l' , 'helvetica' , sans-serif;font-size:12pt;color:#000000"><div>When this =
happpens, is the process holding a single (or very few) shm file references=
, or references to many<br></div><div>shm files ?<br></div><br><div>I wonde=
r if you end up in a scenario where an application very frequently performs=
 exec(), and therefore<br></div><div>sometimes the exec() will happen in th=
e window between the unix socket file descriptor reception and<br></div><di=
v>call to fcntl FD_CLOEXEC.<br></div><br><div>Thanks,<br></div><br><div>Mat=
hieu<br></div><br><div><span id=3D"zwchr">----- On Mar 8, 2022, at 8:29 PM,=
 zhenyu.ren &lt;zhenyu.ren@aliyun.com&gt; wrote:<br></span></div><div><div>=
<span class=3D" __aliyun_node_has_color __aliyun_node_has_color" style=3D"f=
ont-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#=
000000">Thanks a&nbsp; lot for reply. I do not reply it in bug tracker sinc=
e I have not gotten a reliable way to reproduce the leak case.&nbsp;</span>=
</div><div><span class=3D" __aliyun_node_has_color __aliyun_node_has_color"=
 style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:1=
4px;color:#000000">--------------------------------------------------------=
----------</span></div><div><span class=3D" __aliyun_node_has_color __aliyu=
n_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'si=
msun';font-size:14px;color:#000000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMat=
hieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</span></div><div><spa=
n class=3D" __aliyun_node_has_color __aliyun_node_has_color" style=3D"font-=
family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#0000=
00">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=888=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:26</span></div><div><span class=
=3D" __aliyun_node_has_color __aliyun_node_has_color" style=3D"font-family:=
'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E6=
=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&gt;</=
span></div><div><span class=3D" __aliyun_node_has_color __aliyun_node_has_c=
olor" style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-s=
ize:14px;color:#000000">=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AJonathan Rajott=
e &lt;jonathan.rajotte-julien@efficios.com&gt;; lttng-dev &lt;lttng-dev@lis=
ts.lttng.org&gt;</span></div><div><span class=3D" __aliyun_node_has_color _=
_aliyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti'=
 , 'simsun';font-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=
=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =
=E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?</span></div><di=
v><span class=3D" __aliyun_node_has_color __aliyun_node_has_color" style=3D=
"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color=
:#000000"><br></span></div><br><br>-----&nbsp;On&nbsp;Mar&nbsp;8,&nbsp;2022=
,&nbsp;at&nbsp;12:18&nbsp;AM,&nbsp;lttng-dev&nbsp;lttng-dev@lists.lttng.org=
&nbsp;wrote:<br><br>&gt;&nbsp;Hi,<br>&gt;&nbsp;In&nbsp;shm_object_table_app=
end_shm()/alloc_shm()=EF=BC=8C&nbsp;why&nbsp;not&nbsp;calling&nbsp;FD_CLOEX=
EC&nbsp;fcntl()<br>&gt;&nbsp;to&nbsp;shmfds?&nbsp;I&nbsp;guess&nbsp;this&nb=
sp;omission&nbsp;leads&nbsp;to&nbsp;shm&nbsp;fds&nbsp;leak.<br><br>Those&nb=
sp;file&nbsp;descriptors&nbsp;are&nbsp;created&nbsp;when&nbsp;received&nbsp=
;by&nbsp;ustcomm_recv_fds_unix_sock,&nbsp;and<br>immediately&nbsp;after&nbs=
p;creation&nbsp;they&nbsp;are&nbsp;set&nbsp;as&nbsp;FD_CLOEXEC.<br><br>We&n=
bsp;should&nbsp;continue&nbsp;this&nbsp;discussion&nbsp;in&nbsp;the&nbsp;bu=
g&nbsp;tracker&nbsp;as&nbsp;suggested&nbsp;by&nbsp;Jonathan.<br>It&nbsp;wou=
ld&nbsp;greatly&nbsp;help&nbsp;if&nbsp;you&nbsp;can&nbsp;provide&nbsp;a&nbs=
p;small&nbsp;reproducer.<br><br>Thanks,<br><br>Mathieu<br><br><br>&gt;&nbsp=
;Thanks<br>&gt;&nbsp;zhenyu.ren<br><br>&gt;&gt;&nbsp;----------------------=
--------------------------------------------<br>&gt;&gt;&nbsp;=E5=8F=91=E4=
=BB=B6=E4=BA=BA=EF=BC=9AJonathan&nbsp;Rajotte-Julien&nbsp;&lt;jonathan.rajo=
tte-julien@efficios.com&gt;<br>&gt;&gt;&nbsp;=E5=8F=91=E9=80=81=E6=97=B6=E9=
=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8825=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=
=94)&nbsp;22:31<br>&gt;&gt;&nbsp;=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu=
.ren&nbsp;&lt;zhenyu.ren@aliyun.com&gt;<br>&gt;&gt;&nbsp;=E6=8A=84&nbsp;=E9=
=80=81=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;=
&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9ARe:&nbsp;[lttng-dev]&nbsp;=E5=9B=9E=
=E5=A4=8D=EF=BC=9A&nbsp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;leak&nbsp=
;in&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;Hi&nbsp;zhenyu.ren,<=
br><br>&gt;&gt;&nbsp;Please&nbsp;open&nbsp;a&nbsp;bug&nbsp;on&nbsp;our&nbsp=
;bug&nbsp;tracker&nbsp;and&nbsp;provide&nbsp;a&nbsp;reproducer&nbsp;against=
&nbsp;the&nbsp;latest<br>&gt;&gt;&nbsp;stable&nbsp;version&nbsp;(2.13.x).<b=
r><br>&gt;&gt;&nbsp;<a href=3D"https://bugs.lttng.org/" target=3D"_blank" r=
el=3D"nofollow noopener noreferrer">https://bugs.lttng.org/</a><br><br>&gt;=
&gt;&nbsp;Please&nbsp;follow&nbsp;the&nbsp;guidelines:&nbsp;<a href=3D"http=
s://bugs.lttng.org/#Bug-reporting-guidelines" target=3D"_blank" rel=3D"nofo=
llow noopener noreferrer">https://bugs.lttng.org/#Bug-reporting-guidelines<=
/a><br><br>&gt;&gt;&nbsp;Cheers<br><br>&gt;&gt;&nbsp;On&nbsp;Fri,&nbsp;Feb&=
nbsp;25,&nbsp;2022&nbsp;at&nbsp;12:47:34PM&nbsp;+0800,&nbsp;zhenyu.ren&nbsp=
;via&nbsp;lttng-dev&nbsp;wrote:<br>&gt;&gt;&nbsp;&gt;&nbsp;Hi,&nbsp;lttng-d=
ev&nbsp;team<br>&gt;&gt;&gt;&nbsp;When&nbsp;lttng-sessiond&nbsp;exits,&nbsp=
;the&nbsp;ust&nbsp;applications&nbsp;should&nbsp;call<br>&gt;&gt;&gt;&nbsp;=
lttng_ust_objd_table_owner_cleanup()&nbsp;and&nbsp;clean&nbsp;up&nbsp;all&n=
bsp;shm&nbsp;resource(unmap&nbsp;and<br>&gt;&gt;&gt;&nbsp;close).&nbsp;Howe=
rver&nbsp;I&nbsp;do&nbsp;find&nbsp;that&nbsp;the&nbsp;ust&nbsp;applications=
&nbsp;keep&nbsp;opening&nbsp;"all"&nbsp;of&nbsp;the<br>&gt;&gt;&nbsp;&gt;&n=
bsp;shm&nbsp;fds("/dev/shm/ust-shm-consumer-81132&nbsp;(deleted)")&nbsp;and=
&nbsp;do&nbsp;NOT&nbsp;free&nbsp;shm.<br>&gt;&gt;&gt;&nbsp;If&nbsp;we&nbsp;=
run&nbsp;lttng-sessiond&nbsp;again,&nbsp;ust&nbsp;applications&nbsp;can&nbs=
p;get&nbsp;a&nbsp;new&nbsp;piece&nbsp;of&nbsp;shm&nbsp;and<br>&gt;&gt;&gt;&=
nbsp;a&nbsp;new&nbsp;list&nbsp;of&nbsp;shm&nbsp;fds&nbsp;so&nbsp;double&nbs=
p;shm&nbsp;usages.&nbsp;Then&nbsp;if&nbsp;we&nbsp;kill&nbsp;lttng-sessiond,=
<br>&gt;&gt;&gt;&nbsp;what&nbsp;the&nbsp;mostlikely&nbsp;happened&nbsp;is&n=
bsp;ust&nbsp;applications&nbsp;close&nbsp;the&nbsp;new&nbsp;list&nbsp;of&nb=
sp;shm&nbsp;fds<br>&gt;&gt;&gt;&nbsp;and&nbsp;free&nbsp;new&nbsp;shm&nbsp;r=
esource&nbsp;but&nbsp;keeping&nbsp;old&nbsp;shm&nbsp;still.&nbsp;In&nbsp;ot=
her&nbsp;word,&nbsp;we&nbsp;can&nbsp;not<br>&gt;&gt;&nbsp;&gt;&nbsp;free&nb=
sp;this&nbsp;piece&nbsp;of&nbsp;shm&nbsp;unless&nbsp;we&nbsp;killing&nbsp;u=
st&nbsp;applications!!!<br>&gt;&gt;&gt;&nbsp;So&nbsp;Is&nbsp;there&nbsp;any=
&nbsp;possilbe&nbsp;that&nbsp;ust&nbsp;applications&nbsp;failed&nbsp;callin=
g<br>&gt;&gt;&gt;&nbsp;lttng_ust_objd_table_owner_cleanup()?&nbsp;Do&nbsp;y=
ou&nbsp;have&nbsp;ever&nbsp;see&nbsp;this&nbsp;problem?&nbsp;Do&nbsp;you<br=
>&gt;&gt;&gt;&nbsp;have&nbsp;any&nbsp;advice&nbsp;to&nbsp;free&nbsp;the&nbs=
p;shm&nbsp;without&nbsp;killling&nbsp;ust&nbsp;applications(I&nbsp;tried&nb=
sp;to<br>&gt;&gt;&nbsp;&gt;&nbsp;dig&nbsp;into&nbsp;kernel&nbsp;shm_open&nb=
sp;and&nbsp;/dev/shm,&nbsp;but&nbsp;not&nbsp;found&nbsp;any&nbsp;ideas)?<br=
><br>&gt;&gt;&nbsp;&gt;&nbsp;Thanks&nbsp;in&nbsp;advance<br>&gt;&gt;&nbsp;&=
gt;&nbsp;zhenyu.ren<br><br><br><br>&gt;&gt;&nbsp;&gt;&nbsp;----------------=
--------------------------------------------------<br>&gt;&gt;&nbsp;&gt;&nb=
sp;=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;via&nbsp;lttng-dev&n=
bsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=91=
=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=
=98=9F=E6=9C=9F=E4=B8=89)&nbsp;23:09<br>&gt;&gt;&nbsp;&gt;&nbsp;=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;=
<br>&gt;&gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9A[lttng-dev]&nb=
sp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;leak&nbsp;in&nbsp;traced&nbsp;=
application?<br><br>&gt;&gt;&gt;&nbsp;&gt;"I&nbsp;found&nbsp;these&nbsp;ite=
ms&nbsp;also&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp;application&nbsp;wh=
ich&nbsp;is&nbsp;a&nbsp;long-time<br>&gt;&gt;&nbsp;&gt;&nbsp;&gt;running&nb=
sp;daemon"<br>&gt;&gt;&nbsp;&gt;&nbsp;Even&nbsp;if&nbsp;lttng-sessiond&nbsp=
;has&nbsp;been&nbsp;killed!!<br><br>&gt;&gt;&nbsp;&gt;&nbsp;Thanks<br>&gt;&=
gt;&nbsp;&gt;&nbsp;zhenyu.ren<br>&gt;&gt;&nbsp;&gt;&nbsp;------------------=
------------------------------------------------<br>&gt;&gt;&nbsp;&gt;&nbsp=
;=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;via&nbsp;lttng-dev&nbs=
p;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=91=E9=
=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=98=
=9F=E6=9C=9F=E4=B8=89)&nbsp;22:44<br>&gt;&gt;&nbsp;&gt;&nbsp;=E6=94=B6=E4=
=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br=
>&gt;&gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9A[lttng-dev]&nbsp;=
shm&nbsp;leak&nbsp;in&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;&g=
t;&nbsp;Hi,<br>&gt;&gt;&gt;&nbsp;There&nbsp;are&nbsp;many&nbsp;items&nbsp;s=
uch&nbsp;as&nbsp;"/dev/shm/ust-shm-consumer-81132&nbsp;(deleted)"&nbsp;exis=
t<br>&gt;&gt;&gt;&nbsp;in&nbsp;lttng-sessiond&nbsp;fd&nbsp;spaces.&nbsp;I&n=
bsp;know&nbsp;it&nbsp;is&nbsp;the&nbsp;result&nbsp;of&nbsp;shm_open()&nbsp;=
and<br>&gt;&gt;&nbsp;&gt;&nbsp;shm_unlnik()&nbsp;in&nbsp;create_posix_shm()=
.<br>&gt;&gt;&gt;&nbsp;However,&nbsp;today,&nbsp;I&nbsp;found&nbsp;these&nb=
sp;items&nbsp;also&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp;application&n=
bsp;which&nbsp;is<br>&gt;&gt;&gt;&nbsp;a&nbsp;long-time&nbsp;running&nbsp;d=
aemon.&nbsp;The&nbsp;most&nbsp;important&nbsp;thing&nbsp;I&nbsp;found&nbsp;=
is&nbsp;that&nbsp;there<br>&gt;&gt;&nbsp;&gt;&nbsp;seems&nbsp;no&nbsp;relia=
ble&nbsp;way&nbsp;to&nbsp;release&nbsp;share&nbsp;memory.<br>&gt;&gt;&gt;&n=
bsp;I&nbsp;tried&nbsp;to&nbsp;kill&nbsp;lttng-sessiond&nbsp;but&nbsp;not&nb=
sp;always&nbsp;release&nbsp;share&nbsp;memory.&nbsp;Sometimes&nbsp;I<br>&gt=
;&gt;&gt;&nbsp;need&nbsp;to&nbsp;kill&nbsp;the&nbsp;traced&nbsp;application=
&nbsp;to&nbsp;free&nbsp;share&nbsp;memory....But&nbsp;it&nbsp;is&nbsp;not&n=
bsp;a<br>&gt;&gt;&nbsp;&gt;&nbsp;good&nbsp;idea&nbsp;to&nbsp;kill&nbsp;thes=
e&nbsp;applications.<br>&gt;&gt;&nbsp;&gt;&nbsp;My&nbsp;questions&nbsp;are:=
<br>&gt;&gt;&gt;&nbsp;1.&nbsp;Is&nbsp;there&nbsp;any&nbsp;way&nbsp;to&nbsp;=
release&nbsp;share&nbsp;memory&nbsp;without&nbsp;killing&nbsp;any&nbsp;trac=
ed<br>&gt;&gt;&nbsp;&gt;&nbsp;application?<br>&gt;&gt;&gt;&nbsp;2.&nbsp;Is&=
nbsp;it&nbsp;normal&nbsp;that&nbsp;many&nbsp;items&nbsp;such&nbsp;as&nbsp;"=
/dev/shm/ust-shm-consumer-81132<br>&gt;&gt;&nbsp;&gt;&nbsp;(deleted)"&nbsp;=
exist&nbsp;in&nbsp;the&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;&=
gt;&nbsp;Thanks<br>&gt;&gt;&nbsp;&gt;&nbsp;zhenyu.ren<br><br><br><br>&gt;&g=
t;&nbsp;&gt;&nbsp;_______________________________________________<br>&gt;&g=
t;&nbsp;&gt;&nbsp;lttng-dev&nbsp;mailing&nbsp;list<br>&gt;&gt;&nbsp;&gt;&nb=
sp;lttng-dev@lists.lttng.org<br>&gt;&gt;&nbsp;&gt;&nbsp;<a href=3D"https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank" rel=
=3D"nofollow noopener noreferrer">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br><br>&gt;&gt;&nbsp;--<br>&gt;&gt;&nbsp;Jonathan&nbs=
p;Rajotte-Julien<br>&gt;&gt;&nbsp;EfficiOS<br>&gt;&nbsp;___________________=
____________________________<br>&gt;&nbsp;lttng-dev&nbsp;mailing&nbsp;list<=
br>&gt;&nbsp;lttng-dev@lists.lttng.org<br>&gt;&nbsp;<a href=3D"https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank" rel=3D"no=
follow noopener noreferrer">https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev</a><br>--&nbsp;<br>Mathieu&nbsp;Desnoyers<br>EfficiOS&nbsp;Inc.=
<br><a href=3D"http://www.efficios.com" target=3D"_blank" rel=3D"nofollow n=
oopener noreferrer">http://www.efficios.com</a><br></div><br><div>-- <br></=
div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.effici=
os.com" target=3D"_blank" rel=3D"nofollow noopener noreferrer">http://www.e=
fficios.com</a><br data-mce-bogus=3D"1"></div></div></blockquote></div><br>=
</blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br>=
</div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</d=
iv></div></body></html>
--=_16bd5163-5882-4279-83e8-efe4a14e4cbe--



--===============8356484169375359530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8356484169375359530==--


