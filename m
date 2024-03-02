Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84172C54798
	for <lttng-dev@archiver.kernel.org>; Sat,  2 Mar 2024 05:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1709357487;
	bh=Cly3sx6X4i1GK1SUzNIx+ZsWz8dvU/arLBV7QseKM14=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=tTKD5dZbkxs+F2UCqoHb8/BxCfIzASHyt0WCvdI19lhfWeUnQpaQ/lgovLcYxed8w
	 wKyAmWRoSNirj7X5gPn61MSa0tZT1pb3rU/tGRpuN/rUv5ezN/KzKpeVeXvsdyFSXU
	 +uhNqWON64UOfTBAOsT4O/spMPv8P+nh/Snn8ydKBhLS84iRCxTYHqYZVQtoCZKakU
	 IVRgEHGZSOpDMhJ0fMzoNXSL2gPsAnxOID3Z1LF2oZTKEJKg3i8DEbk2EmIIKAPf2b
	 /iwZKmKWpJ2OrKzait7mxwsSvUoxySnejLwKXznFJHy4N8I/eUeuquu2zMnG0ZtCJy
	 Mfp2mynqp0cAQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TmtqL4r4dz2DBq;
	Sat,  2 Mar 2024 00:31:26 -0500 (EST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by lists.lttng.org (Postfix) with ESMTPS id 4TmtqK2fQ0z2DfM
 for <lttng-dev@lists.lttng.org>; Sat,  2 Mar 2024 00:31:25 -0500 (EST)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so31763151fa.1
 for <lttng-dev@lists.lttng.org>; Fri, 01 Mar 2024 21:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709357483; x=1709962283;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWg8W5z3j3VqWjXi8n0PMJ51UGWP0ar3bHTj3NeDHSw=;
 b=MWTK2w+2uRZp1W6keXCqiOv0uXvJQWqj2frs7cYVEXZj9UG7/Ha8/bCwcryhu/cONX
 8krCRPmK5whaP6lDYLgLq4z0v9GllTbkSovfyQ9eTDApZZW4/sKkDqE72PDKb5ccREgJ
 jfqcu2py5gQb9rjDSCONqTh3zLVPJucKvqL6XVHkT9YD1lwCMRhQOke3tO7SVIbvHOnQ
 Hw2qkjLTuQlKIVItiF8h+d0lCumNIpzlZW2Y+JBNmC8lTYDUxxFqEgMhv3gitGRDrCG2
 9w5ysenkGNWB0v/DJA878LazONEXJbLv2iUGaoULJ0KKcUuLu+c1kO5mGH5ZVcOEOzfI
 /iEg==
X-Gm-Message-State: AOJu0YyB/GBOF3Pm1EyvAOidCAp3y/t/4VPWaNS+KDR3cgLK0EcdxTJf
 4Ga7hKHS+ljovrQTfTuGcncvwhN7a9sL0Vs/9zThnTO62XTBtznUmDEqnR4dct1CrqHIxwffuni
 UAb1HZf/BxCxQ1pxAf7jSwdHgGrxUG4idMWU=
X-Google-Smtp-Source: AGHT+IGEliOhGAPHUfDGji9ke2KLs0tAy/W3B7/ppsNKx6Y4pQpjUXX6EDS2qstXK0V8rT/+dvd6sqmGX0f17++4fkw=
X-Received: by 2002:a05:6512:12c9:b0:513:2985:5e05 with SMTP id
 p9-20020a05651212c900b0051329855e05mr2736894lfg.57.1709357483300; Fri, 01 Mar
 2024 21:31:23 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 2 Mar 2024 07:31:12 +0200
Message-ID: <CABRndgwfhU-e1a7f8dFSwV5Pny4cuEeqbhA_4GCkKK=574bVBA@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] tracing user event from multiple dockers
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
From: Zvi Vered via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Zvi Vered <veredz72@gmail.com>
Content-Type: multipart/mixed; boundary="===============3766390451213225876=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3766390451213225876==
Content-Type: multipart/alternative; boundary="000000000000961bb80612a6cd84"

--000000000000961bb80612a6cd84
Content-Type: text/plain; charset="UTF-8"

Hello,

I have an application working with multiple dockers.
Each docker is a fedora O.S running an application.
The host is centos 8.5. This host will be upgraded to RHEL 9.2 in the near
future.
Is it possible that all traces from multiple dockers will all be written to
one metadata ?

versions:
lttng-tools-latest-2.13.tar.bz2
lttng-ust-latest-2.13.tar.bz2
userspace-rcu-latest-0.14.tar.bz2

Thank you,
Zvika

--000000000000961bb80612a6cd84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I have an application=
 working with multiple dockers.</div><div>Each docker is a fedora O.S runni=
ng an application. <br></div><div>The host is centos 8.5. This host will be=
 upgraded to RHEL 9.2 in the near future.</div><div>Is it possible that all=
 traces from multiple dockers will all be written to one metadata ?</div><d=
iv><br></div><div>versions:</div><div>lttng-tools-latest-2.13.tar.bz2</div>=
<div>lttng-ust-latest-2.13.tar.bz2</div><div>userspace-rcu-latest-0.14.tar.=
bz2</div><div><br></div><div>Thank you,</div><div>Zvika <br></div></div>

--000000000000961bb80612a6cd84--

--===============3766390451213225876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3766390451213225876==--
