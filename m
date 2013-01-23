From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH babeltrace 1/2] Add missing shebangs to
	Python examples.
Date: Wed, 23 Jan 2013 12:05:48 -0500
Message-ID: <CAGDH53=N1Ae2cLr5UEDeMBBGwN+pTTwf+dnhTpriPGJ+oL4huA__37275.1401541338$1358960809$gmane$org@mail.gmail.com>
References: <1358898446-1622-1-git-send-email-jeremie.galarneau@efficios.com>
	<20130123144550.GA3952@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Ty3lq-0002xC-VU
	for lttng-dev@lists.lttng.org; Wed, 23 Jan 2013 12:05:55 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so13954258iea.26
	for <lttng-dev@lists.lttng.org>; Wed, 23 Jan 2013 09:05:49 -0800 (PST)
In-Reply-To: <20130123144550.GA3952@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> Please compare with other lttng projects (see tools tests), where I
> think we use "env" and then python. So I'm not sure which roule we want
> to go, but I think this has to do with Debian not having the same
> symlinks that other distros wrt python 2 and 3.

I would recommend using "#!/usr/bin/env python" so it will default to
the Python interpreter available on the machine. Take note that we
might have issues with Python 3 interpreters if the scripts are not
fully compliant.

Thanks,

Christian
