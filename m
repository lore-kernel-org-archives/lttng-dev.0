Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED52C28B2E
	for <lttng-dev@archiver.kernel.org>; Tue, 11 Mar 2025 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741689383;
	bh=iEflrpy6erBLNTSJqzjoLqlJQIPYlnv7S4UNGPp8lM4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=SiPdHhEbEUdwIgT3T7r4F5vzLkeXukqmPJvSzqfWRcaSWytosgYwlaS5xMecRqYgC
	 Tdm9eddrjsIsDLxxqV4mcTyfZYTpc57Y7pzAD3MP7lumByq/4r+gl/HaV0Dm+5QlN7
	 gkFYqBMbzJF0DtLUnTnt/S42pefnWcMGa8NUe2rTlCjX1yyG1/iTCt8qmpZOpCley5
	 aibRb7xOnuo2zid1AqJaAO00LkKUSW++uGO0rp4b59jutLmPI4n+FQaMXcQDrS8/8i
	 cRYFKvKgFffiOhv+CnwjLGOVKawy5i81xTgB5qf2JvTNw6huc0FLdrUWEUpkDCYJ+2
	 vVc13szOvspgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBqtb204Bz203v;
	Tue, 11 Mar 2025 06:36:23 -0400 (EDT)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZBqtZ3pkpz206J
 for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2025 06:36:22 -0400 (EDT)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so8135031a91.2
 for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2025 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689381; x=1742294181;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I4T/4XddBYrwT7DeSKef2eTKEbd9NWR8Fqj44qe4aRc=;
 b=JxNVbXKWVStoiVyLIqCH7YQPvK9kUzVZ4249aINd2OfoqXypDOAiPpRWQDJ1ATRjub
 hZ9e3Mr+dpMZvSe18QmdjUV4VfDNlsz8Tddc27RbyIohtVKxShmBX1rm+2uJMNoICA9+
 JogLRn+U4bsmkhNfMAo+/rUPsfYMPk30EBVjtRYCln71aaWqgeN+frdBAZz5m/YP4Btu
 LRUVQDpefA6KRL036ajn2cg2vhLhlIttfGVGj9z/OutsyeX5lZjaTi7ye1Yad8u3Dkdi
 YfNRxNR0PRj0ECpo+jz5b6SiKO3FINYY57lWmE8QrdiljyUwiQM6tasM5sM6fCzkbwhK
 sgDA==
X-Gm-Message-State: AOJu0YzH4+78QHJ/9oSiTe8wUtFwjK1Hnhs7sJq5+R8voknI7WJtSRUu
 LktJNraxPnPsTESlyPGDuL0FevLj1fTqw0yCmm4nMI4H/4G+lJJcOL21VDLk7kkpVi9Z+z3CkJ4
 6mebRVMX1J+96wtySRdlfErzQoB39HvyY8dw=
X-Gm-Gg: ASbGncvF2MlmcoBJyj+FP2d5JttQqlpRDKfPzkT0YuuZSpMFvHot25Yl0FdSh1Yzukh
 AFfp6/Uz/OAhB9PA7jl4NUbtF8buy1GePW57r5YyyYj1qmZXJUm6SUxwMXyXBDAxdAlJZx/ay8z
 zDQAhQ6mBiyVZi+PicYQNaDEBdXg==
X-Google-Smtp-Source: AGHT+IH9hsUNLH4zyh+5l5woqoBW5bGOElciG0u1zUNJsDJ9Pcqb4+vPwGmZ8Sg5Ep3zgY+PuW/eqcfWfLP1xXYTsYc=
X-Received: by 2002:a17:90a:c886:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-300ff0a4374mr3910898a91.1.1741689381103; Tue, 11 Mar 2025
 03:36:21 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 11 Mar 2025 16:05:45 +0530
X-Gm-Features: AQ5f1JqnfLyCeoRAWRhshVH2YnIspTC7cUIiekZpsrTMcrXo40eQY9LGn1vfYAI
Message-ID: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
Subject: Memory Consumption High After Upgrading to 2.13 from 2.10
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000deb5ad06300ea894"
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
From: Gour DEV via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Gour DEV <lakshyagour10@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000deb5ad06300ea894
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have recently upgraded from lttng 2.10 to 2.13 as part of servers
migration from buster to bookworm.

lttng 2.10.6 - KeKriek to lttng 2.13.9 - Nordicit=C3=A9

I see an increase in memory consumption upto 11Gig after my recent upgrade.


In buster

root@localhost:~# top -b -n 1 | grep lttng
PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
4296 root 20 0 1003676 19616 4608 S 0.0 0.1 0:00.67 lttng-sessiond
4297 root 20 0 44260 800 0 S 0.0 0.0 0:00.00 lttng-runas
4643 root 20 0 5838512 10396 9204 S 0.0 0.0 0:09.24 lttng-consumerd
4646 root 20 0 48048 544 0 S 0.0 0.0 0:00.00 lttng-runas


In bookworm
In bookworm.
root@edgecore-40XKE-j2-101-32:~# top -b -n 1 | grep lttng
PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
4824 root 20 0 1098824 13336 5980 S 11.8 0.0 0:03.46 lttng-s+
4825 root 20 0 48872 2188 1012 S 0.0 0.0 0:00.00 lttng-r+
4841 root 20 0 11.5g 11.0g 11.0g S 0.0 35.4 2:33.33 lttng-c+
4843 root 20 0 3680 1160 816 S 0.0 0.0 0:00.23 lttng-r+


I have a python script which was used to enable channels, these were the
parameters I was using
large_channels_sz =3D 4000000
medium_channels_sz =3D 200000
small_channels_sz =3D 10000

num_large =3D 4
num_medium =3D 4
num_small =3D 4

def enable_channel(channels, session, subbuf_size, subbuf_num):
for c in channels:
call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size',
str(subbuf_size), '--num-subbuf', str(subbuf_num),],
stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)

enable_channel(large_channels, def_session, large_channels_sz, num_large)
enable_channel(medium_channels, def_session, medium_channels_sz, num_medium=
)
enable_channel(small_channels, def_session, small_channels_sz, num_small)



there are total 16 large channels and 6 medium channels and no small
channels.


The total size for all these session cominded turn out to be machine
roughly 7GB on my 32 core machine, which is still less that the amount of
memory used by the lttng-consumerd.

I only have default session configured and nothing else

root@edgecore-40XKE-j2-101-32:~# lttng list
Available recording sessions:
1) default [active snapshot]




I have seen that when only the channel are enable and no process which is
using lttng is running then, I see normal memory consumption.


root@edgecore-40XKE-j2-101-32:~# top -b -n 1 | grep lttng

PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
4824 root 20 0 1098184 12732 5376 S 0.0 0.0 0:03.15 lttng-s+
4825 root 20 0 48872 2188 1012 S 0.0 0.0 0:00.00 lttng-r+
4841 root 20 0 536240 4284 2400 S 0.0 0.0 2:09.32 lttng-c+
4843 root 20 0 3680 1160 816 S 0.0 0.0 0:00.23 lttng-r+


But, as soon as I run even an single process which is linked to lttng, and
which is *not* using any lttng channel

liblttng-ust.so.1 =3D> /lib/x86_64-linux-gnu/liblttng-ust.so.1 (0x
00007fa867ea3000)
liblttng-ust-common.so.1 =3D> /lib/x86_64-linux-gnu/liblttng-ust-common.so.=
1 (
0x00007fa86752d000)
liblttng-ust-tracepoint.so.1 =3D>
/lib/x86_64-linux-gnu/liblttng-ust-tracepoint.so.1
(0x00007fa86750b000)

I see an very high memory consumption of 5.5g and when i run all the
process then i see the total memory consumption reaching uptop 11G.


Do you have any hints on why this could be happening,

Thank You.

--000000000000deb5ad06300ea894
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br><br></div>I have recently upgraded fro=
m lttng 2.10 to 2.13 as part of servers migration from buster to bookworm.<=
br><br></div><div>lttng 2.10.6 - KeKriek to lttng 2.13.9 - Nordicit=C3=A9<b=
r><br></div><div>I see an increase in memory consumption upto 11Gig after m=
y recent upgrade.</div><div><br></div><div><div><br></div><div>In buster</d=
iv><div style=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font=
-family:&quot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&=
quot;,monospace;font-weight:normal;font-size:12px;line-height:18px;white-sp=
ace:pre-wrap"><div><span style=3D"color:rgb(204,204,204)"><br>root</span><s=
pan style=3D"color:rgb(212,212,212)">@</span><span style=3D"color:rgb(204,2=
04,204)">localhost:</span><span style=3D"color:rgb(212,212,212)">~</span><s=
pan style=3D"color:rgb(106,153,85)"># top -b -n 1 | grep  lttng<br></span><=
div style=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-fam=
ily:&quot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot=
;,monospace;font-weight:normal;font-size:12px;line-height:18px;white-space:=
pre-wrap"><div><span style=3D"color:rgb(204,204,204)">  PID USER      PR  N=
I    VIRT    RES    SHR S  </span><span style=3D"color:rgb(212,212,212)">%<=
/span><span style=3D"color:rgb(204,204,204)">CPU  </span><span style=3D"col=
or:rgb(212,212,212)">%</span><span style=3D"color:rgb(204,204,204)">MEM    =
 TIME</span><span style=3D"color:rgb(212,212,212)">+</span><span style=3D"c=
olor:rgb(204,204,204)"> COMMAND</span></div></div></div><div><span style=3D=
"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168)">429=
6</span><span style=3D"color:rgb(204,204,204)"> root      </span><span styl=
e=3D"color:rgb(181,206,168)">20</span><span style=3D"color:rgb(204,204,204)=
">   </span><span style=3D"color:rgb(181,206,168)">0</span><span style=3D"c=
olor:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168)">10036=
76</span><span style=3D"color:rgb(204,204,204)">  </span><span style=3D"col=
or:rgb(181,206,168)">19616</span><span style=3D"color:rgb(204,204,204)">   =
</span><span style=3D"color:rgb(181,206,168)">4608</span><span style=3D"col=
or:rgb(204,204,204)"> S   </span><span style=3D"color:rgb(181,206,168)">0.0=
</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"colo=
r:rgb(181,206,168)">0.1</span><span style=3D"color:rgb(204,204,204)">   </s=
pan><span style=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb=
(204,204,204)">:</span><span style=3D"color:rgb(181,206,168)">00.67</span><=
span style=3D"color:rgb(204,204,204)"> lttng</span><span style=3D"color:rgb=
(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">sessiond</spa=
n></div><div><span style=3D"color:rgb(204,204,204)"> </span><span style=3D"=
color:rgb(181,206,168)">4297</span><span style=3D"color:rgb(204,204,204)"> =
root      </span><span style=3D"color:rgb(181,206,168)">20</span><span styl=
e=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168=
)">0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"=
color:rgb(181,206,168)">44260</span><span style=3D"color:rgb(204,204,204)">=
    </span><span style=3D"color:rgb(181,206,168)">800</span><span style=3D"=
color:rgb(204,204,204)">      </span><span style=3D"color:rgb(181,206,168)"=
>0</span><span style=3D"color:rgb(204,204,204)"> S   </span><span style=3D"=
color:rgb(181,206,168)">0.0</span><span style=3D"color:rgb(204,204,204)">  =
 </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=3D"col=
or:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0</sp=
an><span style=3D"color:rgb(204,204,204)">:</span><span style=3D"color:rgb(=
181,206,168)">00.00</span><span style=3D"color:rgb(204,204,204)"> lttng</sp=
an><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(=
204,204,204)">runas</span></div><div><span style=3D"color:rgb(204,204,204)"=
> </span><span style=3D"color:rgb(181,206,168)">4643</span><span style=3D"c=
olor:rgb(204,204,204)"> root      </span><span style=3D"color:rgb(181,206,1=
68)">20</span><span style=3D"color:rgb(204,204,204)">   </span><span style=
=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">=
 </span><span style=3D"color:rgb(181,206,168)">5838512</span><span style=3D=
"color:rgb(204,204,204)">  </span><span style=3D"color:rgb(181,206,168)">10=
396</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"c=
olor:rgb(181,206,168)">9204</span><span style=3D"color:rgb(204,204,204)"> S=
   </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=3D"c=
olor:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0.0=
</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"colo=
r:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">:</span>=
<span style=3D"color:rgb(181,206,168)">09.24</span><span style=3D"color:rgb=
(204,204,204)"> lttng</span><span style=3D"color:rgb(212,212,212)">-</span>=
<span style=3D"color:rgb(204,204,204)">consumerd</span></div><div><span sty=
le=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168)=
">4646</span><span style=3D"color:rgb(204,204,204)"> root      </span><span=
 style=3D"color:rgb(181,206,168)">20</span><span style=3D"color:rgb(204,204=
,204)">   </span><span style=3D"color:rgb(181,206,168)">0</span><span style=
=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)=
">48048</span><span style=3D"color:rgb(204,204,204)">    </span><span style=
=3D"color:rgb(181,206,168)">544</span><span style=3D"color:rgb(204,204,204)=
">      </span><span style=3D"color:rgb(181,206,168)">0</span><span style=
=3D"color:rgb(204,204,204)"> S   </span><span style=3D"color:rgb(181,206,16=
8)">0.0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=
=3D"color:rgb(181,206,168)">0.0</span><span style=3D"color:rgb(204,204,204)=
">   </span><span style=3D"color:rgb(181,206,168)">0</span><span style=3D"c=
olor:rgb(204,204,204)">:</span><span style=3D"color:rgb(181,206,168)">00.00=
</span><span style=3D"color:rgb(204,204,204)"> lttng</span><span style=3D"c=
olor:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">runas=
<br><br></span></div></div><div><br></div><div>In bookworm <br><div style=
=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&quot=
;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monospa=
ce;font-weight:normal;font-size:12px;line-height:18px;white-space:pre-wrap"=
><div><span style=3D"color:rgb(204,204,204)">In bookworm.</span></div><div>=
<span style=3D"color:rgb(204,204,204)">root</span><span style=3D"color:rgb(=
212,212,212)">@</span><span style=3D"color:rgb(204,204,204)">edgecore</span=
><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(24=
4,71,71)">40XKE</span><span style=3D"color:rgb(212,212,212)">-</span><span =
style=3D"color:rgb(204,204,204)">j2</span><span style=3D"color:rgb(212,212,=
212)">-</span><span style=3D"color:rgb(181,206,168)">101</span><span style=
=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(181,206,168)">=
32</span><span style=3D"color:rgb(204,204,204)">:</span><span style=3D"colo=
r:rgb(212,212,212)">~</span><span style=3D"color:rgb(106,153,85)"># top -b =
-n 1 | grep  lttng<br></span><div style=3D"color:rgb(204,204,204);backgroun=
d-color:rgb(31,31,31);font-family:&quot;JetBrainsMono Nerd Font&quot;,Menlo=
,Monaco,&quot;Courier New&quot;,monospace;font-weight:normal;font-size:12px=
;line-height:18px;white-space:pre-wrap"><div><span style=3D"color:rgb(204,2=
04,204)">    PID USER      PR  NI    VIRT    RES    SHR S  </span><span sty=
le=3D"color:rgb(212,212,212)">%</span><span style=3D"color:rgb(204,204,204)=
">CPU  </span><span style=3D"color:rgb(212,212,212)">%</span><span style=3D=
"color:rgb(204,204,204)">MEM     TIME</span><span style=3D"color:rgb(212,21=
2,212)">+</span><span style=3D"color:rgb(204,204,204)"> COMMAND</span></div=
></div></div><div><span style=3D"color:rgb(204,204,204)">   </span><span st=
yle=3D"color:rgb(181,206,168)">4824</span><span style=3D"color:rgb(204,204,=
204)"> root      </span><span style=3D"color:rgb(181,206,168)">20</span><sp=
an style=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,=
206,168)">0</span><span style=3D"color:rgb(204,204,204)"> </span><span styl=
e=3D"color:rgb(181,206,168)">1098824</span><span style=3D"color:rgb(204,204=
,204)">  </span><span style=3D"color:rgb(181,206,168)">13336</span><span st=
yle=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,1=
68)">5980</span><span style=3D"color:rgb(204,204,204)"> S  </span><span sty=
le=3D"color:rgb(181,206,168)">11.8</span><span style=3D"color:rgb(204,204,2=
04)">   </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=
=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)=
">0</span><span style=3D"color:rgb(204,204,204)">:</span><span style=3D"col=
or:rgb(181,206,168)">03.46</span><span style=3D"color:rgb(204,204,204)"> lt=
tng</span><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"col=
or:rgb(204,204,204)">s</span><span style=3D"color:rgb(212,212,212)">+</span=
></div><div><span style=3D"color:rgb(204,204,204)">   </span><span style=3D=
"color:rgb(181,206,168)">4825</span><span style=3D"color:rgb(204,204,204)">=
 root      </span><span style=3D"color:rgb(181,206,168)">20</span><span sty=
le=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,16=
8)">0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D=
"color:rgb(181,206,168)">48872</span><span style=3D"color:rgb(204,204,204)"=
>   </span><span style=3D"color:rgb(181,206,168)">2188</span><span style=3D=
"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">1=
012</span><span style=3D"color:rgb(204,204,204)"> S   </span><span style=3D=
"color:rgb(181,206,168)">0.0</span><span style=3D"color:rgb(204,204,204)"> =
  </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=3D"co=
lor:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0</s=
pan><span style=3D"color:rgb(204,204,204)">:</span><span style=3D"color:rgb=
(181,206,168)">00.00</span><span style=3D"color:rgb(204,204,204)"> lttng</s=
pan><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb=
(204,204,204)">r</span><span style=3D"color:rgb(212,212,212)">+</span></div=
><div><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"color=
:rgb(181,206,168)">4841</span><span style=3D"color:rgb(204,204,204)"> root =
     </span><span style=3D"color:rgb(181,206,168)">20</span><span style=3D"=
color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0<=
/span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"color=
:rgb(181,206,168)">11.</span><span style=3D"color:rgb(244,71,71)">5g</span>=
<span style=3D"color:rgb(204,204,204)">  </span><span style=3D"color:rgb(18=
1,206,168)">11.</span><span style=3D"color:rgb(244,71,71)">0g</span><span s=
tyle=3D"color:rgb(204,204,204)">  </span><span style=3D"color:rgb(181,206,1=
68)">11.</span><span style=3D"color:rgb(244,71,71)">0g</span><span style=3D=
"color:rgb(204,204,204)"> S   </span><span style=3D"color:rgb(181,206,168)"=
>0.0</span><span style=3D"color:rgb(204,204,204)">  </span><span style=3D"c=
olor:rgb(181,206,168)">35.4</span><span style=3D"color:rgb(204,204,204)">  =
 </span><span style=3D"color:rgb(181,206,168)">2</span><span style=3D"color=
:rgb(204,204,204)">:</span><span style=3D"color:rgb(181,206,168)">33.33</sp=
an><span style=3D"color:rgb(204,204,204)"> lttng</span><span style=3D"color=
:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">c</span><=
span style=3D"color:rgb(212,212,212)">+</span></div><div><span style=3D"col=
or:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">4843<=
/span><span style=3D"color:rgb(204,204,204)"> root      </span><span style=
=3D"color:rgb(181,206,168)">20</span><span style=3D"color:rgb(204,204,204)"=
>   </span><span style=3D"color:rgb(181,206,168)">0</span><span style=3D"co=
lor:rgb(204,204,204)">    </span><span style=3D"color:rgb(181,206,168)">368=
0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"col=
or:rgb(181,206,168)">1160</span><span style=3D"color:rgb(204,204,204)">    =
</span><span style=3D"color:rgb(181,206,168)">816</span><span style=3D"colo=
r:rgb(204,204,204)"> S   </span><span style=3D"color:rgb(181,206,168)">0.0<=
/span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"color=
:rgb(181,206,168)">0.0</span><span style=3D"color:rgb(204,204,204)">   </sp=
an><span style=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(=
204,204,204)">:</span><span style=3D"color:rgb(181,206,168)">00.23</span><s=
pan style=3D"color:rgb(204,204,204)"> lttng</span><span style=3D"color:rgb(=
212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">r</span><span =
style=3D"color:rgb(212,212,212)">+</span></div><div><span style=3D"color:rg=
b(204,204,204)">   </span></div></div><br></div><div><br></div><div>I have =
a python script which was used to enable channels, these were the parameter=
s I was using<div style=3D"color:rgb(204,204,204);background-color:rgb(31,3=
1,31);font-family:&quot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Co=
urier New&quot;,monospace;font-weight:normal;font-size:12px;line-height:18p=
x;white-space:pre-wrap"><div><span style=3D"color:rgb(204,204,204)">large_c=
hannels_sz </span><span style=3D"color:rgb(212,212,212)">=3D</span><span st=
yle=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168=
)">4000000</span></div><div><span style=3D"color:rgb(204,204,204)">medium_c=
hannels_sz </span><span style=3D"color:rgb(212,212,212)">=3D</span><span st=
yle=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168=
)">200000</span></div><div><span style=3D"color:rgb(204,204,204)">small_cha=
nnels_sz </span><span style=3D"color:rgb(212,212,212)">=3D</span><span styl=
e=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168)"=
>10000</span></div><br><div><span style=3D"color:rgb(204,204,204)">num_larg=
e </span><span style=3D"color:rgb(212,212,212)">=3D</span><span style=3D"co=
lor:rgb(204,204,204)"> </span><span style=3D"color:rgb(181,206,168)">4</spa=
n></div><div><span style=3D"color:rgb(204,204,204)">num_medium </span><span=
 style=3D"color:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,20=
4,204)"> </span><span style=3D"color:rgb(181,206,168)">4</span></div><div><=
span style=3D"color:rgb(204,204,204)">num_small </span><span style=3D"color=
:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,204,204)"> </span=
><span style=3D"color:rgb(181,206,168)">4<br><br></span><div style=3D"color=
:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&quot;JetBrain=
sMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monospace;font-w=
eight:normal;font-size:12px;line-height:18px;white-space:pre-wrap"><div><sp=
an style=3D"color:rgb(86,156,214)">def</span><span style=3D"color:rgb(204,2=
04,204)"> </span><span style=3D"color:rgb(220,220,170)">enable_channel</spa=
n><span style=3D"color:rgb(204,204,204)">(</span><span style=3D"color:rgb(1=
56,220,254)">channels</span><span style=3D"color:rgb(204,204,204)">, </span=
><span style=3D"color:rgb(156,220,254)">session</span><span style=3D"color:=
rgb(204,204,204)">, </span><span style=3D"color:rgb(156,220,254)">subbuf_si=
ze</span><span style=3D"color:rgb(204,204,204)">, </span><span style=3D"col=
or:rgb(156,220,254)">subbuf_num</span><span style=3D"color:rgb(204,204,204)=
">):</span></div><div><span style=3D"color:rgb(204,204,204)">    </span><sp=
an style=3D"color:rgb(197,134,192)">for</span><span style=3D"color:rgb(204,=
204,204)"> c </span><span style=3D"color:rgb(197,134,192)">in</span><span s=
tyle=3D"color:rgb(204,204,204)"> channels:</span></div><div><span style=3D"=
color:rgb(204,204,204)">        call([</span><span style=3D"color:rgb(206,1=
45,120)">&#39;lttng&#39;</span><span style=3D"color:rgb(204,204,204)">, </s=
pan><span style=3D"color:rgb(206,145,120)">&#39;enable-channel&#39;</span><=
span style=3D"color:rgb(204,204,204)">, </span><span style=3D"color:rgb(206=
,145,120)">&#39;-u&#39;</span><span style=3D"color:rgb(204,204,204)">, c, <=
/span><span style=3D"color:rgb(206,145,120)">&#39;-s&#39;</span><span style=
=3D"color:rgb(204,204,204)">, session, </span><span style=3D"color:rgb(206,=
145,120)">&#39;--subbuf-size&#39;</span><span style=3D"color:rgb(204,204,20=
4)">,</span></div><div><span style=3D"color:rgb(204,204,204)">             =
</span><span style=3D"color:rgb(78,201,176)">str</span><span style=3D"color=
:rgb(204,204,204)">(subbuf_size), </span><span style=3D"color:rgb(206,145,1=
20)">&#39;--num-subbuf&#39;</span><span style=3D"color:rgb(204,204,204)">, =
</span><span style=3D"color:rgb(78,201,176)">str</span><span style=3D"color=
:rgb(204,204,204)">(subbuf_num),],</span></div><div><span style=3D"color:rg=
b(204,204,204)">             </span><span style=3D"color:rgb(156,220,254)">=
stdout</span><span style=3D"color:rgb(212,212,212)">=3D</span><span style=
=3D"color:rgb(204,204,204)">devnull, </span><span style=3D"color:rgb(156,22=
0,254)">stderr</span><span style=3D"color:rgb(212,212,212)">=3D</span><span=
 style=3D"color:rgb(204,204,204)">subprocess.STDOUT)<br><br></span><div sty=
le=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&qu=
ot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monos=
pace;font-weight:normal;font-size:12px;line-height:18px;white-space:pre-wra=
p"><div><span style=3D"color:rgb(204,204,204)"> enable_channel(large_channe=
ls, def_session, large_channels_sz, num_large)</span></div><div><span style=
=3D"color:rgb(204,204,204)"> enable_channel(medium_channels, def_session, m=
edium_channels_sz, num_medium)</span></div><div><span style=3D"color:rgb(20=
4,204,204)"> enable_channel(small_channels, def_session, small_channels_sz,=
 num_small)<br><br></span></div></div><br></div></div><br></div><div>there =
are total 16 large channels and 6 medium channels and no small channels.</d=
iv></div><br></div><div><br></div><div>The
 total size for all these session cominded turn out to be machine=20
roughly 7GB on my 32 core machine, which is still less that the amount=20
of memory used by the lttng-consumerd.<br><br></div><div>I only have defaul=
t session configured and nothing else<br><br><div style=3D"color:rgb(204,20=
4,204);background-color:rgb(31,31,31);font-family:&quot;JetBrainsMono Nerd =
Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monospace;font-weight:norma=
l;font-size:12px;line-height:18px;white-space:pre-wrap"><div><span style=3D=
"color:rgb(204,204,204)">root</span><span style=3D"color:rgb(212,212,212)">=
@</span><span style=3D"color:rgb(204,204,204)">edgecore</span><span style=
=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(244,71,71)">40=
XKE</span><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"col=
or:rgb(204,204,204)">j2</span><span style=3D"color:rgb(212,212,212)">-</spa=
n><span style=3D"color:rgb(181,206,168)">101</span><span style=3D"color:rgb=
(212,212,212)">-</span><span style=3D"color:rgb(181,206,168)">32</span><spa=
n style=3D"color:rgb(204,204,204)">:</span><span style=3D"color:rgb(212,212=
,212)">~</span><span style=3D"color:rgb(106,153,85)"># lttng list</span></d=
iv><div><span style=3D"color:rgb(204,204,204)">Available recording sessions=
:</span></div><div><span style=3D"color:rgb(204,204,204)">  </span><span st=
yle=3D"color:rgb(181,206,168)">1</span><span style=3D"color:rgb(204,204,204=
)">) default [active snapshot]</span></div><br><br></div><br></div><div><br=
></div><div>I
 have seen that when only the channel are enable and no process which is
 using lttng is running then, I see normal memory consumption.<br><br><div =
style=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-family:=
&quot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,mo=
nospace;font-weight:normal;font-size:12px;line-height:18px;white-space:pre-=
wrap"><br><div><span style=3D"color:rgb(204,204,204)">root</span><span styl=
e=3D"color:rgb(212,212,212)">@</span><span style=3D"color:rgb(204,204,204)"=
>edgecore</span><span style=3D"color:rgb(212,212,212)">-</span><span style=
=3D"color:rgb(244,71,71)">40XKE</span><span style=3D"color:rgb(212,212,212)=
">-</span><span style=3D"color:rgb(204,204,204)">j2</span><span style=3D"co=
lor:rgb(212,212,212)">-</span><span style=3D"color:rgb(181,206,168)">101</s=
pan><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb=
(181,206,168)">32</span><span style=3D"color:rgb(204,204,204)">:</span><spa=
n style=3D"color:rgb(212,212,212)">~</span><span style=3D"color:rgb(106,153=
,85)"># top -b -n 1 | grep  lttng</span></div><div><br><div><div style=3D"c=
olor:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&quot;JetB=
rainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monospace;fo=
nt-weight:normal;font-size:12px;line-height:18px;white-space:pre-wrap"><div=
><span style=3D"color:rgb(204,204,204)">    PID USER      PR  NI    VIRT   =
 RES    SHR S  </span><span style=3D"color:rgb(212,212,212)">%</span><span =
style=3D"color:rgb(204,204,204)">CPU  </span><span style=3D"color:rgb(212,2=
12,212)">%</span><span style=3D"color:rgb(204,204,204)">MEM     TIME</span>=
<span style=3D"color:rgb(212,212,212)">+</span><span style=3D"color:rgb(204=
,204,204)"> COMMAND</span></div></div></div><span style=3D"color:rgb(204,20=
4,204)">  </span><span style=3D"color:rgb(181,206,168)">4824</span><span st=
yle=3D"color:rgb(204,204,204)"> root      </span><span style=3D"color:rgb(1=
81,206,168)">20</span><span style=3D"color:rgb(204,204,204)">   </span><spa=
n style=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204=
,204)"> </span><span style=3D"color:rgb(181,206,168)">1098184</span><span s=
tyle=3D"color:rgb(204,204,204)">  </span><span style=3D"color:rgb(181,206,1=
68)">12732</span><span style=3D"color:rgb(204,204,204)">   </span><span sty=
le=3D"color:rgb(181,206,168)">5376</span><span style=3D"color:rgb(204,204,2=
04)"> S   </span><span style=3D"color:rgb(181,206,168)">0.0</span><span sty=
le=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,16=
8)">0.0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=
=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">=
:</span><span style=3D"color:rgb(181,206,168)">03.15</span><span style=3D"c=
olor:rgb(204,204,204)"> lttng</span><span style=3D"color:rgb(212,212,212)">=
-</span><span style=3D"color:rgb(204,204,204)">s</span><span style=3D"color=
:rgb(212,212,212)">+</span></div><div><span style=3D"color:rgb(204,204,204)=
">   </span><span style=3D"color:rgb(181,206,168)">4825</span><span style=
=3D"color:rgb(204,204,204)"> root      </span><span style=3D"color:rgb(181,=
206,168)">20</span><span style=3D"color:rgb(204,204,204)">   </span><span s=
tyle=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,20=
4)">   </span><span style=3D"color:rgb(181,206,168)">48872</span><span styl=
e=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168=
)">2188</span><span style=3D"color:rgb(204,204,204)">   </span><span style=
=3D"color:rgb(181,206,168)">1012</span><span style=3D"color:rgb(204,204,204=
)"> S   </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=
=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)=
">0.0</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D=
"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">:</=
span><span style=3D"color:rgb(181,206,168)">00.00</span><span style=3D"colo=
r:rgb(204,204,204)"> lttng</span><span style=3D"color:rgb(212,212,212)">-</=
span><span style=3D"color:rgb(204,204,204)">r</span><span style=3D"color:rg=
b(212,212,212)">+</span></div><div><span style=3D"color:rgb(204,204,204)"> =
  </span><span style=3D"color:rgb(181,206,168)">4841</span><span style=3D"c=
olor:rgb(204,204,204)"> root      </span><span style=3D"color:rgb(181,206,1=
68)">20</span><span style=3D"color:rgb(204,204,204)">   </span><span style=
=3D"color:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">=
  </span><span style=3D"color:rgb(181,206,168)">536240</span><span style=3D=
"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">4=
284</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"c=
olor:rgb(181,206,168)">2400</span><span style=3D"color:rgb(204,204,204)"> S=
   </span><span style=3D"color:rgb(181,206,168)">0.0</span><span style=3D"c=
olor:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0.0=
</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"colo=
r:rgb(181,206,168)">2</span><span style=3D"color:rgb(204,204,204)">:</span>=
<span style=3D"color:rgb(181,206,168)">09.32</span><span style=3D"color:rgb=
(204,204,204)"> lttng</span><span style=3D"color:rgb(212,212,212)">-</span>=
<span style=3D"color:rgb(204,204,204)">c</span><span style=3D"color:rgb(212=
,212,212)">+</span></div><div><span style=3D"color:rgb(204,204,204)">   </s=
pan><span style=3D"color:rgb(181,206,168)">4843</span><span style=3D"color:=
rgb(204,204,204)"> root      </span><span style=3D"color:rgb(181,206,168)">=
20</span><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"co=
lor:rgb(181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">    </=
span><span style=3D"color:rgb(181,206,168)">3680</span><span style=3D"color=
:rgb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">1160</s=
pan><span style=3D"color:rgb(204,204,204)">    </span><span style=3D"color:=
rgb(181,206,168)">816</span><span style=3D"color:rgb(204,204,204)"> S   </s=
pan><span style=3D"color:rgb(181,206,168)">0.0</span><span style=3D"color:r=
gb(204,204,204)">   </span><span style=3D"color:rgb(181,206,168)">0.0</span=
><span style=3D"color:rgb(204,204,204)">   </span><span style=3D"color:rgb(=
181,206,168)">0</span><span style=3D"color:rgb(204,204,204)">:</span><span =
style=3D"color:rgb(181,206,168)">00.23</span><span style=3D"color:rgb(204,2=
04,204)"> lttng</span><span style=3D"color:rgb(212,212,212)">-</span><span =
style=3D"color:rgb(204,204,204)">r</span><span style=3D"color:rgb(212,212,2=
12)">+</span></div></div><br><br></div><div>But, as soon as I run even an s=
ingle process which is linked to lttng, and which is <b>not</b> using any l=
ttng channel<div style=3D"color:rgb(204,204,204);background-color:rgb(31,31=
,31);font-family:&quot;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Cou=
rier New&quot;,monospace;font-weight:normal;font-size:12px;line-height:18px=
;white-space:pre-wrap"><br><div><span style=3D"color:rgb(204,204,204)">libl=
ttng</span><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"co=
lor:rgb(204,204,204)">ust.so.1 </span><span style=3D"color:rgb(212,212,212)=
">=3D&gt;</span><span style=3D"color:rgb(204,204,204)"> </span><span style=
=3D"color:rgb(212,212,212)">/</span><span style=3D"color:rgb(204,204,204)">=
lib</span><span style=3D"color:rgb(212,212,212)">/</span><span style=3D"col=
or:rgb(204,204,204)">x86_64</span><span style=3D"color:rgb(212,212,212)">-<=
/span><span style=3D"color:rgb(204,204,204)">linux</span><span style=3D"col=
or:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">gnu</sp=
an><span style=3D"color:rgb(212,212,212)">/</span><span style=3D"color:rgb(=
204,204,204)">liblttng</span><span style=3D"color:rgb(212,212,212)">-</span=
><span style=3D"color:rgb(204,204,204)">ust.so.1 (</span><span style=3D"col=
or:rgb(86,156,214)">0x</span><span style=3D"color:rgb(181,206,168)">00007fa=
867ea3000</span><span style=3D"color:rgb(204,204,204)">)</span></div><div><=
span style=3D"color:rgb(204,204,204)">liblttng</span><span style=3D"color:r=
gb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">ust</span><=
span style=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,=
204,204)">common.so.1 </span><span style=3D"color:rgb(212,212,212)">=3D&gt;=
</span><span style=3D"color:rgb(204,204,204)"> </span><span style=3D"color:=
rgb(212,212,212)">/</span><span style=3D"color:rgb(204,204,204)">lib</span>=
<span style=3D"color:rgb(212,212,212)">/</span><span style=3D"color:rgb(204=
,204,204)">x86_64</span><span style=3D"color:rgb(212,212,212)">-</span><spa=
n style=3D"color:rgb(204,204,204)">linux</span><span style=3D"color:rgb(212=
,212,212)">-</span><span style=3D"color:rgb(204,204,204)">gnu</span><span s=
tyle=3D"color:rgb(212,212,212)">/</span><span style=3D"color:rgb(204,204,20=
4)">liblttng</span><span style=3D"color:rgb(212,212,212)">-</span><span sty=
le=3D"color:rgb(204,204,204)">ust</span><span style=3D"color:rgb(212,212,21=
2)">-</span><span style=3D"color:rgb(204,204,204)">common.so.1 (</span><spa=
n style=3D"color:rgb(86,156,214)">0x</span><span style=3D"color:rgb(181,206=
,168)">00007fa86752d000</span><span style=3D"color:rgb(204,204,204)">)</spa=
n></div><div><span style=3D"color:rgb(204,204,204)">liblttng</span><span st=
yle=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204=
)">ust</span><span style=3D"color:rgb(212,212,212)">-</span><span style=3D"=
color:rgb(204,204,204)">tracepoint.so.1 </span><span style=3D"color:rgb(212=
,212,212)">=3D&gt;</span><span style=3D"color:rgb(204,204,204)"> </span><sp=
an style=3D"color:rgb(212,212,212)">/</span><span style=3D"color:rgb(204,20=
4,204)">lib</span><span style=3D"color:rgb(212,212,212)">/</span><span styl=
e=3D"color:rgb(204,204,204)">x86_64</span><span style=3D"color:rgb(212,212,=
212)">-</span><span style=3D"color:rgb(204,204,204)">linux</span><span styl=
e=3D"color:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)"=
>gnu</span><span style=3D"color:rgb(212,212,212)">/</span><span style=3D"co=
lor:rgb(204,204,204)">liblttng</span><span style=3D"color:rgb(212,212,212)"=
>-</span><span style=3D"color:rgb(204,204,204)">ust</span><span style=3D"co=
lor:rgb(212,212,212)">-</span><span style=3D"color:rgb(204,204,204)">tracep=
oint.so.1 (</span><span style=3D"color:rgb(86,156,214)">0x</span><span styl=
e=3D"color:rgb(181,206,168)">00007fa86750b000</span><span style=3D"color:rg=
b(204,204,204)">)</span></div></div><br></div><div>I
 see an very high memory consumption of 5.5g and when i run all the=20
process then i see the total memory consumption reaching uptop 11G.</div><d=
iv><br></div><div><br></div><div>Do you have any hints on why this could be=
 happening, <br><br></div><div>Thank You.</div><br></div></div>

--000000000000deb5ad06300ea894--
