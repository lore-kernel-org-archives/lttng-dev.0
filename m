Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B066C433B4
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 15:51:46 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9B461002
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 15:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9B461002
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9W5W3kbTzRv8;
	Wed, 31 Mar 2021 11:51:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617205904;
	bh=FV/ymknzh1FmhUIGop1vw2p2zbUcDYEyyLGJBZ7mYhI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=gxy9P5IvTu+XGRYy9Rqat+m5jL/p1dXS7Tn1B8x9RBzms/ZnOhckKhrsJriAmUf6A
	 eg1BjbMoI2vF83zW0Ikzib765N7TQoOqdrZAByAiacmFLwSBoRtb8zNyih9jMfeoZ+
	 m2X5i4QKIItw6ZClFmsJu5VSNn5C1LP5tPILT1nXRCo2b1g+7mENFRqFnBhD8s9JX3
	 nncde8svkxm2Db8geD9nfHLIS1Mtq8UoxHLwYHvDOCP3lvw7Dz42sEOqSnEWX6UCi0
	 V7FbIkQk/XGwCW/2CAzS9iDvazeMqFgno18npRTQYogk8GqIL1GLGzriuB6/TM5Kzs
	 ePgk/Fy1xXgVA==
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9W5V08h6zSFW
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 11:51:41 -0400 (EDT)
Received: by mail-lj1-x236.google.com with SMTP id 184so24406953ljf.9
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 08:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0gZHdAoCMakciXjaGl4gjLkLrGBiT0Sa16WPK1DHa0M=;
 b=IKH5xmEsE2HrZVd2pweiQpbre5G5rWTGH3NfuU1BmaOrZ34OxYZm0KcS7uMnr+WU+s
 LAFa0Y+9El3GHRrRfz3E3pomz9UmkW1hS9IrCp1PuaLim7/KeYRGZh4Ig666673vlkcZ
 29YnwFKukgv7hIH6Csg6lFS2ft/+5ZA3ttRr4IlzWREvbbyJuG9nwCliMf91v6mVygjQ
 uDIfdKvWlI3sn1C+VPNMUwhO04k61jh3v+lYn7vJVMkh9L+2gQp/lBuGrcrRfvlqVwop
 yC6ls5/Wfxovmx2pevhIp+Pj6+QKYs2eSOuWiFLFk0J3no1FCj3NAnZtKvJkCBh4Evc3
 eBlQ==
X-Gm-Message-State: AOAM532wAFsmgPLH/uvzbFpdcN33CgNpbJS3sOf8XlXYk5EbSAz42IlO
 KQh3gJMwJCKQ93zTYbTwAIL/RKvFWWV/ks28RalrEmacSRSRUQ==
X-Google-Smtp-Source: ABdhPJwd4snDEZSsAZcaEmgWbV75Cv8SB2kK4SYRNObVA3fy1cFXLKRKZEaMQt0jjjT6DdOZiDQRcXHHZ4Xu1EVcEPE=
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr2428406ljo.411.1617205899853; 
 Wed, 31 Mar 2021 08:51:39 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 31 Mar 2021 10:51:03 -0500
Message-ID: <CAFGSPrw1Ev1c+Ok7tvyzEJOQNDze6fbpzNKFzmH=9hSVYGF69A@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Can't trace function calls
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
From: Ramesh Errabolu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Content-Type: multipart/mixed; boundary="===============0345384555615401094=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0345384555615401094==
Content-Type: multipart/alternative; boundary="00000000000030839c05bed717f1"

--00000000000030839c05bed717f1
Content-Type: text/plain; charset="UTF-8"

I am trying to capture the list of functions being called by an app. The
app relies on a couple of shared libraries (libhsa-runtime64.so and
libhsakmt.so).

My experiments all *FAIL *i.e. there are no log files of the output. The
link on lttng-ust-cyg-profile does not tell me where I can get them.
Instrument the build files for the two libraries to allow function tracing
by the gcc/clang flags -finstrument-functions and run workload as follows

   - Instrument the build files for the two libraries to allow function
   tracing by the gcc/clang flags *-finstrument-functions* and run workload
   as follows
      - LD_PRELOAD=liblttng-ust-cyg-profile.so   ./rocminfo
   - Instrument the application as well for the gcc/clang flag along with
   the two libs
   - LD_PRELOAD=liblttng-ust-cyg-profile.so   ./rocminfo

I am using LTTng version Ubuntu: LTTng Stable 2.12 PPA

   - apt-get install lttng-tools
   - apt-get install lttng-modules-dkms
   - apt-get install liblttng-ust-dev

I noticed no kernel modules with substring "ltt" in it.

Any help is appreciated.

Regards,
Ramesh

--00000000000030839c05bed717f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">I am trying to capture the list of functions being called by an=
 app. The app relies on a couple of shared libraries (libhsa-runtime64.so a=
nd libhsakmt.so). <br><br>My experiments all <b>FAIL </b>i.e. there are no =
log files of the output. The link on lttng-ust-cyg-profile does not tell me=
 where I can get them.<br>Instrument the build files for the two libraries =
to allow function tracing by the gcc/clang flags -finstrument-functions and=
 run workload as follows</div><div class=3D"gmail_default" style=3D"font-fa=
mily:verdana,sans-serif"><ul><li>Instrument the build files for the two lib=
raries to allow function tracing by the gcc/clang flags=C2=A0<b>-finstrumen=
t-functions</b>=C2=A0and run workload as follows</li><ul><li>LD_PRELOAD=3Dl=
iblttng-ust-cyg-profile.so =C2=A0 ./rocminfo</li></ul><li>Instrument the ap=
plication as well for the gcc/clang flag along with the two libs<br></li><u=
l><li>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so =C2=A0 ./rocminfo</li></ul><=
/ul></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif">I am using LTTng version=C2=A0<span style=3D"font-family:Arial,Helveti=
ca,sans-serif">Ubuntu: LTTng Stable 2.12 PPA</span></div><ul><li>apt-get in=
stall lttng-tools</li><li>apt-get install lttng-modules-dkms</li><li>apt-ge=
t install liblttng-ust-dev</li></ul><div><div dir=3D"ltr" class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div class=3D"gmail_default" st=
yle=3D"font-family:verdana,sans-serif">I noticed no kernel modules with sub=
string &quot;ltt&quot; in it.</div><div class=3D"gmail_default" style=3D"fo=
nt-family:verdana,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif">Any help is appreciated.</div></div><di=
v dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=
<br></div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature">Regards,<div>Ramesh</div></div></div></div>

--00000000000030839c05bed717f1--

--===============0345384555615401094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0345384555615401094==--
