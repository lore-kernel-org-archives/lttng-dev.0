From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH babeltrace 1/2] Added Python 3.0 or better
 requirement to the README file
Date: Mon, 11 Mar 2013 22:55:00 -0400
Message-ID: <513E9904.2050201__32800.7296812304$1363056957$gmane$org@gmail.com>
References: <1359640251-6133-1-git-send-email-jeremie.galarneau@efficios.com>
	<510BA252.3020604@gmail.com>
	<CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFFMr-0002oL-2k
	for lttng-dev@lists.lttng.org; Mon, 11 Mar 2013 22:55:09 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so4024838obc.26
	for <lttng-dev@lists.lttng.org>; Mon, 11 Mar 2013 19:55:03 -0700 (PDT)
In-Reply-To: <CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g@mail.gmail.com>
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

On 2013-02-01 08:54, J=E9r=E9mie Galarneau wrote:
> As for as I know, the bindings do work with Python 2.7.
> However, we have decided to no longer explicitly support older
> versions of Python in order to make the bindings, along with future
> developments, easily maintainable.
>
My main concern is that 2.7 is still the default version for many linux
distribution, so it might be early to drop 2.7 support.

Yannick
