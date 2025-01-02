Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70444E77188
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Jan 2025 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1736177934;
	bh=ZG5focMBh/o5fDDcGwJkHYDua7L/xD+NmdS1h+l2W2I=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=wkyoU8ag8VW4v6vHfUhSB13lNfNv9aZAkIeC+d4zqzgZOQgQ/77DRMAbGEGhNkik4
	 Sm8nYt3FJcssmCKjDtdS1X0RA94dR5jAPszNdGaYN3+BJXksJNoUFgpgoBGdfMHIRO
	 +Krc1Exu4Y1DmsVTq8gjy+7z+7c0YxX5foU/EQTPFf1E399ATtinUCdnlw/gYDwi8g
	 0RkY32+dZTdYsN3raM/PBaALNbZ13B0qj5p/BfhZ4o00nYe6COUyPem8D1AlZD9doA
	 frBSLpPxkIRGK9edGvSdnSQbou+wuSLDq7EujwQou8rh6n9Co0EsIcvE6dbUMELbTl
	 Dy56Gxq3YIk/A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YRdd958xgz1PT0;
	Mon,  6 Jan 2025 10:38:53 -0500 (EST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by lists.lttng.org (Postfix) with ESMTPS id 4YPLbY5Gklz1nvn
 for <lttng-dev@lists.lttng.org>; Thu,  2 Jan 2025 17:14:33 -0500 (EST)
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ab37d98dd4so44814695ab.3
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jan 2025 14:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735856072; x=1736460872;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KuZUhJnJQVwGyfy9th2zjHagFL6jhxy7yGGwBdBChM=;
 b=huOBjnrsxcnKiPZTk6rb6Xr0BOPaDsCxodDOCfVNM1PGFgv9MbNIM0XU20PBz57t4D
 xlgdWk53rjolipIZ+HWlptzT90iBEMGnOcq6aOGlRaN41x/APo7j63a5YSnVvyt9h0OU
 oyDGWddqiE+e3p6xet0TcHy5F2RvBU+wykF0XVtcHbwzvpKlI6XFF3eS7fTAkE4B1oFy
 rlKfAt1Et6UxM7XgnBuGv4oquGxefSaaAuQbsAtY1znXvyTL79PFH9NtjRD4vjfwLga7
 U41/B+zJDfdanPuOQ/zUBG1GwPJRErvZ5A03+k3RYddsu0oQrz++Ac6YiUB0IWxBKZB4
 6xuQ==
X-Gm-Message-State: AOJu0Yz0MFI4dqBuzqeUp7BznA0bvHUgf1krvv62Qge0ahtseKlIr3pm
 DwRxlb7oxkQA7T/LoDKWCo6a3vVCBnKV8OU7QQ34NNyyw9AbZuUqNN1GkUhxklFoaox+3Xd/Grz
 jV9VjCIVc4AIxq7EBi5ozbCc6Acb9vZdH4Vn5jwrI+cKlK2p5MDck
X-Gm-Gg: ASbGnctALYGdKLXmSkGLoNKfhBhkrvHrB4+BSmoCcG47zsLOuzi2P5jh6WclyZxlQT4
 ilG27s9k3v2L5AzISeXiVuOIQUlFX4K+/Xzo7hDtR
X-Google-Smtp-Source: AGHT+IEBqE7/mk7obF+ex68SPGMRtB02Yfakd1woe9wkXDxdgiTtkz79XTFgenHeWaZgyRD2R0QhU0X4Y9g7VjTsTpE=
X-Received: by 2002:a05:6e02:260b:b0:3a7:819c:5129 with SMTP id
 e9e14a558f8ab-3c2d48a3256mr403524095ab.18.1735856072432; Thu, 02 Jan 2025
 14:14:32 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 2 Jan 2025 23:14:16 +0100
Message-ID: <CAOYL4NkHoS1PBhmC7uHu-oX1hZjAZBWbTTCaJCZg8QBGhg8X5Q@mail.gmail.com>
Subject: Tracing Ceph with LTTng-UST issue
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="0000000000009437c1062ac07c95"
X-Mailman-Approved-At: Mon, 06 Jan 2025 10:38:52 -0500
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
From: Lina SADI via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lina SADI <kl_sadi@esi.dz>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000009437c1062ac07c95
Content-Type: text/plain; charset="UTF-8"

Hello,

We are writing to you regarding an issue we encountered while attempting to
trace Ceph with LTTng-UST. Below are the steps we have followed so far:

   1.

   *Compiling Ceph with LTTng Support*:
   - We modified the debian/rules file to enable LTTng support using the
      following flags: -DWITH_LTTNG=ON and
      -DWITH_OSD_INSTRUMENT_FUNCTIONS=ON.
      - The compilation process took approximately 7 hours on a virtual
      machine running Debian 12 with a kernel version 6.1.0-27-amd64, 8 GB of
      RAM, and 2 CPU cores.
      - The build steps can be found in our GitHub
      <https://github.com/KedadsaChakib/ceph-configuration/blob/main/build/README.md>
       repository.
   2.

   *Deploying a Ceph Cluster*:
   - We deployed the cluster manually (1MON,1MGR,2OSDs). Please find the
      script here
      <https://github.com/KedadsaChakib/ceph-configuration/blob/main/cluster/cluster-dep-script.sh>
      .
   3.

   *Attempting to Trace with LTTng-UST*:
   - We tried listing the tracepoints using the following command :

      # lttng list -u

      - This command did not return any Ceph-related tracepoints:

      UST events:
      -------------
      NONE

      4.

   *Preloading liblttng-ust-fork.so*:
   - We attempted to preload liblttng-ust-fork.so before starting the Ceph
      daemons (MON, OSD, MGR) as follows:

      # systemctl edit ceph-mon@debian

      - We added the following configuration:

      [Service]
      Environment="LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-fork.so



   - After restarting the daemons, we executed lttng list -u, which
      displayed tracepoints related to the libraries (lttng_ust_lib:*),
      trace logs (lttng_ust_tracelog:*), and state dump events (
      lttng_ust_statedump:*), instead of the expected Ceph-related
      tracepoints.

*Expected Result*:

   UST events:
   -------------
   PID: 100859 - Name: /path/to/ceph-osd
       pg:queue_op (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
       osd:do_osd_op_post (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)
       osd:do_osd_op_pre_unknown (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)
       osd:do_osd_op_pre_copy_from (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)
       osd:do_osd_op_pre_copy_get (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)
       ...


*Actual Result*:

   UST events:
   -------------
   lttng_ust_lib:*
   lttng_ust_tracelog:*
   lttng_ust_statedump:*


We would greatly appreciate any help  you could provide to resolve this problem.

--0000000000009437c1062ac07c95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>Hello,=C2=A0</p><p>We are writing to y=
ou regarding an issue we encountered while attempting to trace Ceph with LT=
Tng-UST. Below are the steps we have followed so far:</p><ol><li style=3D"m=
argin-left:15px"><p><strong>Compiling Ceph with LTTng Support</strong>:</p>=
<ul><li style=3D"margin-left:15px">We modified the=C2=A0<code>debian/rules<=
/code>=C2=A0file to enable LTTng support using the following flags:=C2=A0<c=
ode>-DWITH_LTTNG=3DON</code>=C2=A0and=C2=A0<code>-DWITH_OSD_INSTRUMENT_FUNC=
TIONS=3DON</code>.</li><li style=3D"margin-left:15px">The compilation proce=
ss took approximately 7 hours on a virtual machine running Debian 12 with a=
 kernel version 6.1.0-27-amd64, 8 GB of RAM, and 2 CPU cores.</li><li style=
=3D"margin-left:15px">The build steps can be found in our=C2=A0<a href=3D"h=
ttps://github.com/KedadsaChakib/ceph-configuration/blob/main/build/README.m=
d" target=3D"_blank"><span id=3D"m_8519080378035158935gmail-mt-tracked-link=
_3_1734452876581" style=3D"color:red"></span>GitHub</a>=C2=A0repository.</l=
i></ul></li><li style=3D"margin-left:15px"><p><strong>Deploying a Ceph Clus=
ter</strong>:</p><ul><li style=3D"margin-left:15px">We deployed the cluster=
 manually (1MON,1MGR,2OSDs). Please find the script=C2=A0<a href=3D"https:/=
/github.com/KedadsaChakib/ceph-configuration/blob/main/cluster/cluster-dep-=
script.sh" target=3D"_blank"><span id=3D"m_8519080378035158935gmail-mt-trac=
ked-link_3_1734452915856" style=3D"color:red"></span>here</a>.</li></ul></l=
i><li style=3D"margin-left:15px"><p><strong>Attempting to Trace with LTTng-=
UST</strong>:</p><ul><li style=3D"margin-left:15px">We tried listing the tr=
acepoints using the following command :</li><div dir=3D"ltr"><div style=3D"=
box-sizing:border-box;margin:1px 0px 24px;border:1px solid rgb(225,228,229)=
;overflow-x:auto;font-family:Lato,proxima-nova,&quot;Helvetica Neue&quot;,A=
rial,sans-serif;font-size:16px;background-color:rgb(252,252,252)"><div styl=
e=3D"box-sizing:border-box;background:white;border:none;overflow-x:auto;mar=
gin:0px;padding:0px"><pre style=3D"box-sizing:border-box;font-family:SFMono=
-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier Ne=
w&quot;,Courier,monospace;font-size:12px;line-height:1.4;margin-top:0px;mar=
gin-bottom:0px;padding:12px;overflow:auto"><font color=3D"#444444"># lttng =
list -u</font></pre></div></div></div><li style=3D"margin-left:15px">This c=
ommand did not return any Ceph-related tracepoints:</li><div dir=3D"ltr"><d=
iv style=3D"box-sizing:border-box;margin:1px 0px 24px;border:1px solid rgb(=
225,228,229);overflow-x:auto;background-color:rgb(252,252,252)"><div style=
=3D"box-sizing:border-box;background:white;border:none;overflow-x:auto;marg=
in:0px;padding:0px"><pre style=3D"box-sizing:border-box;line-height:1.4;mar=
gin-top:0px;margin-bottom:0px;padding:12px;overflow:auto"><font color=3D"#4=
44444" face=3D"SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Co=
urier New, Courier, monospace">UST events:
-------------
NONE</font><font face=3D"SFMono-Regular, Menlo, Monaco, Consolas, Liberatio=
n Mono, Courier New, Courier, monospace"></font></pre></div></div></div></u=
l></li><li style=3D"margin-left:15px"><p><strong>Preloading=C2=A0<code>libl=
ttng-ust-fork.so</code></strong>:</p></li><ul><li style=3D"margin-left:15px=
">We attempted to preload=C2=A0<code>liblttng-ust-fork.so</code>=C2=A0befor=
e starting the Ceph daemons (MON, OSD, MGR) as follows:</li><div dir=3D"ltr=
"><div style=3D"box-sizing:border-box;margin:1px 0px 24px;border:1px solid =
rgb(225,228,229);overflow-x:auto;background-color:rgb(252,252,252)"><div st=
yle=3D"box-sizing:border-box;background:white;border:none;overflow-x:auto;m=
argin:0px;padding:0px"><pre style=3D"box-sizing:border-box;line-height:1.4;=
margin-top:0px;margin-bottom:0px;padding:12px;overflow:auto"><font color=3D=
"#444444" face=3D"SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono,=
 Courier New, Courier, monospace"># systemctl edit ceph-mon@debian</font></=
pre></div></div></div><li style=3D"margin-left:15px">We added the following=
 configuration:</li><div dir=3D"ltr"><div style=3D"box-sizing:border-box;ma=
rgin:1px 0px 24px;border:1px solid rgb(225,228,229);overflow-x:auto;backgro=
und-color:rgb(252,252,252)"><div style=3D"box-sizing:border-box;background:=
white;border:none;overflow-x:auto;margin:0px;padding:0px"><pre style=3D"box=
-sizing:border-box;line-height:1.4;margin-top:0px;margin-bottom:0px;padding=
:12px;overflow:auto"><font color=3D"#444444" face=3D"SFMono-Regular, Menlo,=
 Monaco, Consolas, Liberation Mono, Courier New, Courier, monospace">[Servi=
ce]
Environment=3D&quot;LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/liblttng-ust-for=
k.so</font></pre></div></div></div></ul></ol><ol><ul><li style=3D"margin-le=
ft:15px">After restarting the daemons, we executed=C2=A0<code>lttng list -u=
</code>, which displayed tracepoints related to the libraries (<code>lttng_=
ust_lib:*</code>), trace logs (<code>lttng_ust_tracelog:*</code>), and stat=
e dump events (<code>lttng_ust_statedump:*</code>), instead of the expected=
 Ceph-related tracepoints.</li></ul></ol><p><strong>Expected Result</strong=
>:</p><ul><div dir=3D"ltr"><div style=3D"box-sizing:border-box;margin:1px 0=
px 24px;border:1px solid rgb(225,228,229);overflow-x:auto;background-color:=
rgb(252,252,252)"><div style=3D"box-sizing:border-box;background:white;bord=
er:none;overflow-x:auto;margin:0px;padding:0px"><pre style=3D"box-sizing:bo=
rder-box;line-height:1.4;margin-top:0px;margin-bottom:0px;padding:12px;over=
flow:auto"><font color=3D"#444444" face=3D"SFMono-Regular, Menlo, Monaco, C=
onsolas, Liberation Mono, Courier New, Courier, monospace">UST events: =20
------------- =20
PID: 100859 - Name: /path/to/ceph-osd =20
    pg:queue_op (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint) =20
    osd:do_osd_op_post (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)=
 =20
    osd:do_osd_op_pre_unknown (loglevel: TRACE_DEBUG_LINE (13)) (type: trac=
epoint) =20
    osd:do_osd_op_pre_copy_from (loglevel: TRACE_DEBUG_LINE (13)) (type: tr=
acepoint) =20
    osd:do_osd_op_pre_copy_get (loglevel: TRACE_DEBUG_LINE (13)) (type: tra=
cepoint) =20
    ...  </font><font face=3D"SFMono-Regular, Menlo, Monaco, Consolas, Libe=
ration Mono, Courier New, Courier, monospace"></font></pre></div></div></di=
v></ul><pre style=3D"text-wrap-mode: wrap;"><div><strong style=3D"font-fami=
ly:Arial,Helvetica,sans-serif">Actual Result</strong><span style=3D"font-fa=
mily:Arial,Helvetica,sans-serif">:</span></div><div><ul><div dir=3D"ltr"><d=
iv style=3D"box-sizing:border-box;margin:1px 0px 24px;border:1px solid rgb(=
225,228,229);overflow-x:auto;background-color:rgb(252,252,252)"><div style=
=3D"box-sizing:border-box;background:white;border:none;overflow-x:auto;marg=
in:0px;padding:0px"><pre style=3D"box-sizing:border-box;line-height:1.4;mar=
gin-top:0px;margin-bottom:0px;padding:12px;overflow:auto"><font color=3D"#4=
44444" face=3D"SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Co=
urier New, Courier, monospace">UST events:
-------------
lttng_ust_lib:*
lttng_ust_tracelog:*
lttng_ust_statedump:*</font></pre></div></div></div></ul></div></pre><pre s=
tyle=3D"text-wrap-mode: wrap;"><div dir=3D"ltr"><span style=3D"font-family:=
Arial,Helvetica,sans-serif">We would greatly appreciate any help=C2=A0 you =
could provide to resolve this problem.</span></div></pre></div><img width=
=3D"0" height=3D"0" class=3D"mailtrack-img" alt=3D"" style=3D"display:flex"=
 src=3D"https://mailtrack.io/trace/mail/b4fbf56655c3737e27948e030c2553428ee=
4ed72.png?u=3D11358644"></div>

--0000000000009437c1062ac07c95--
