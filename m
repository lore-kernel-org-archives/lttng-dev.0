From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Error: Unable to list kernel events: Kernel tracer
 not available
Date: Mon, 3 Dec 2018 11:37:45 -0500
Message-ID: <20181203163745.GC28340__35926.1243291714$1543854951$gmane$org@joraj-alpa>
References: <CAN=_VanV7dh13y8Y787W-zgAisUiEejhKD+4EO2qwWCPXWk79g@mail.gmail.com>
 <20181201000518.GA28340@joraj-alpa>
 <CAN=_Va=ibpRorwzkryNdjfJ5-L4U4V1kgddA6sXeqQ6ye0DYYA@mail.gmail.com>
 <20181203143626.GB28340@joraj-alpa>
 <CAN=_VamhBm1Bnz=tsnF5R8LdqQ6vb9AzLTFUwkzviNRmEUjdkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 437rJW2mJKzxkD
 for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2018 11:37:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAN=_VamhBm1Bnz=tsnF5R8LdqQ6vb9AzLTFUwkzviNRmEUjdkA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Szymon =?utf-8?B?UsSFcGHFgmE=?= <rompacz00@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> Done.
> Unpacking lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) over
> (2.10.8-1~ubuntu16.04.1) ...
> Setting up lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) ...
> Loading new lttng-modules-2.10.8 DKMS files...
> Building for 4.4.0-98-generic and 4.4.0-139-generic
> Module build for the currently running kernel was skipped since the
> kernel source for this kernel does not seem to be installed.

I would bet that you are missing the kernel header for the 4.4.0-98-generic
kernel.

	sudo apt-get install linux-headers-4.4.0-98-generic

I'm not sure if dkms triggers on header install but if I were you I would simply
force a reinstall of the lttng-modules-dkms package and make sure that the
modules are installed for both the 98 and 139 kernel.

Cheers


-- 
Jonathan Rajotte-Julien
EfficiOS
