From: Santhosh Samarthyam <srsamarthyam@gmail.com>
Subject: LTTng on Android
Date: Thu, 16 Aug 2012 18:07:07 +0530
Message-ID: <CAMJ-Osde+NDU1U8d4Rew7tNfMnqXZU20n0Dq7cKY4YbkAM4hLw__1180.52036637$1345120680$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <srsamarthyam@gmail.com>) id 1T1zKO-0001kG-Uk
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 08:37:33 -0400
Received: by yenm12 with SMTP id m12so3565658yen.35
	for <lttng-dev@lists.lttng.org>; Thu, 16 Aug 2012 05:37:27 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Dear All,

I have been closely following the status of LTTng on Android based on
the discussions in this mailing list.
I would be great if someone could validate the following

- No need for LTTng kernel patch if kernel version > 2.6.38
- No dependency on glibc after version 2.0 of lttng.

So can I build LTTng on Android (Version details below)

Android version: Icecream sandwich (4.0.1)
Kernel version: 3.0.1

Can we build the following on an ARM based board running android?
(After creating the android make files)
LTTng-tools 2.0.4
LTTng-modules 2.0.4
LTTng-UST 2.0.4
liburcu 0.7.3

I am more interested in getting the LTTng-UST to work.
Any pointers on how to achieve this would be really helpful.

-- 
Cheers,
Santos
