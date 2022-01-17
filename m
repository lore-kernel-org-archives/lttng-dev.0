Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18F8C433F5
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Jan 2022 15:02:49 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JcwBJ0d7lzHr2;
	Mon, 17 Jan 2022 10:02:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642431768;
	bh=c9MM+Sxy2eSwheUIh1Z3TC6blNug5cC80UD9L/NZw8o=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IZivRqvQlBnG0Uu7jUi2x13zT/hmUeEykAXhghuJ8xUIJF5d2XE1MM8/Bb8GOjHYY
	 smApoMf6IUTzEx/d8PywxoWNIGU8exuEYVNffdVIhcWnqpdYrMc8eLCC7tjQU3MvH+
	 7Zvc7XsoIuZFRRiSCeP4zNwm+5sKSdNLpWitYFWqUQFNeQngMgj7Adg6tfNCMS2kzV
	 B4zphDav+oQ9pLbTr64ZW5dNjP47mrAS1y3aga9o8wcedT0ahF/ELV/+ZYSmYrM91W
	 kt9d02aEJqwRxv2+oTWtGbdNeUBGU9J8+FefoOtBsNLd830XqJ/SJZcuAuD5LBLsfD
	 qbV90J3vucZlQ==
Received: from albert.ini-tech.com (ns542098.ip-144-217-255.net
 [144.217.255.55])
 by lists.lttng.org (Postfix) with ESMTPS id 4JcwBH0pdyzHnG
 for <lttng-dev@lists.lttng.org>; Mon, 17 Jan 2022 10:02:46 -0500 (EST)
Received: from smtp.ev0ke.net (unknown [10.2.3.24])
 by albert.ini-tech.com (Postfix) with ESMTP id 4D6F9D5B0;
 Mon, 17 Jan 2022 15:02:40 +0000 (UTC)
Date: Mon, 17 Jan 2022 10:02:07 -0500
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20220117150207.7o6vblg7yotsqjop@raoul>
References: <20220114204845.285640-1-jeremie.galarneau@efficios.com>
In-Reply-To: <20220114204845.285640-1-jeremie.galarneau@efficios.com>
Subject: Re: [lttng-dev] [PATCH lttng-tools] Copyright ownership transfer
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
From: David Goulet via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Goulet <dgoulet@ev0ke.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0262509533580897659=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--===============0262509533580897659==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o7mlsa6dfbbotglc"
Content-Disposition: inline


--o7mlsa6dfbbotglc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Jan (15:48:45), J=E9r=E9mie Galarneau wrote:
> Apply copyright ownership transfer from David Goulet, Julien Desfossez,
> and Simon Marchi to EfficiOS Inc.
>=20
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030087.html
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> Cc: David Goulet <dgoulet@ev0ke.net>
> Cc: Julien Desfossez <ju@klipix.org>
> Cc: Simon Marchi <simon.marchi@efficios.com>
> Change-Id: Id13575afd4a2a09bb91a8d2b7a12dc3db8dc329f
> ---
>  extras/lttng-bash_completion                   | 2 +-
>  include/lttng/lttng.h                          | 2 +-
>  src/bin/lttng-consumerd/lttng-consumerd.cpp    | 2 +-
>  src/bin/lttng-consumerd/lttng-consumerd.h      | 4 ++--
>  src/bin/lttng-crash/lttng-crash.cpp            | 2 +-
>  src/bin/lttng-sessiond/channel.cpp             | 2 +-
>  src/bin/lttng-sessiond/channel.h               | 2 +-
>  src/bin/lttng-sessiond/client.cpp              | 2 +-
>  src/bin/lttng-sessiond/client.h                | 2 +-
>  src/bin/lttng-sessiond/context.cpp             | 2 +-
>  src/bin/lttng-sessiond/context.h               | 2 +-
>  src/bin/lttng-sessiond/dispatch.cpp            | 2 +-
>  src/bin/lttng-sessiond/dispatch.h              | 2 +-
>  src/bin/lttng-sessiond/event.cpp               | 2 +-
>  src/bin/lttng-sessiond/event.h                 | 2 +-
>  src/bin/lttng-sessiond/globals.cpp             | 2 +-
>  src/bin/lttng-sessiond/kernel.cpp              | 2 +-
>  src/bin/lttng-sessiond/kernel.h                | 2 +-
>  src/bin/lttng-sessiond/lttng-sessiond.h        | 2 +-
>  src/bin/lttng-sessiond/main.cpp                | 2 +-
>  src/bin/lttng-sessiond/manage-apps.cpp         | 2 +-
>  src/bin/lttng-sessiond/manage-apps.h           | 2 +-
>  src/bin/lttng-sessiond/manage-consumer.cpp     | 2 +-
>  src/bin/lttng-sessiond/manage-consumer.h       | 2 +-
>  src/bin/lttng-sessiond/manage-kernel.cpp       | 2 +-
>  src/bin/lttng-sessiond/manage-kernel.h         | 2 +-
>  src/bin/lttng-sessiond/process-utils.cpp       | 2 +-
>  src/bin/lttng-sessiond/register.cpp            | 2 +-
>  src/bin/lttng-sessiond/register.h              | 2 +-
>  src/bin/lttng-sessiond/session.cpp             | 2 +-
>  src/bin/lttng-sessiond/session.h               | 2 +-
>  src/bin/lttng-sessiond/thread-utils.cpp        | 2 +-
>  src/bin/lttng-sessiond/trace-kernel.cpp        | 2 +-
>  src/bin/lttng-sessiond/trace-kernel.h          | 2 +-
>  src/bin/lttng-sessiond/trace-ust.cpp           | 2 +-
>  src/bin/lttng-sessiond/trace-ust.h             | 2 +-
>  src/bin/lttng-sessiond/ust-app.cpp             | 2 +-
>  src/bin/lttng-sessiond/ust-app.h               | 2 +-
>  src/bin/lttng-sessiond/ust-consumer.cpp        | 2 +-
>  src/bin/lttng-sessiond/ust-consumer.h          | 2 +-
>  src/bin/lttng-sessiond/ust-ctl-internal.h      | 2 +-
>  src/bin/lttng-sessiond/ust-error-internal.h    | 3 +--
>  src/bin/lttng-sessiond/utils.cpp               | 2 +-
>  src/bin/lttng-sessiond/utils.h                 | 2 +-
>  src/bin/lttng/command.h                        | 2 +-
>  src/bin/lttng/commands/add_context.cpp         | 2 +-
>  src/bin/lttng/commands/create.cpp              | 2 +-
>  src/bin/lttng/commands/destroy.cpp             | 2 +-
>  src/bin/lttng/commands/disable_channels.cpp    | 2 +-
>  src/bin/lttng/commands/disable_events.cpp      | 2 +-
>  src/bin/lttng/commands/enable_channels.cpp     | 2 +-
>  src/bin/lttng/commands/enable_events.cpp       | 2 +-
>  src/bin/lttng/commands/list.cpp                | 2 +-
>  src/bin/lttng/commands/set_session.cpp         | 2 +-
>  src/bin/lttng/commands/start.cpp               | 2 +-
>  src/bin/lttng/commands/stop.cpp                | 2 +-
>  src/bin/lttng/commands/track-untrack.cpp       | 2 +-
>  src/bin/lttng/commands/version.cpp             | 2 +-
>  src/bin/lttng/conf.cpp                         | 2 +-
>  src/bin/lttng/conf.h                           | 2 +-
>  src/bin/lttng/lttng.cpp                        | 2 +-
>  src/bin/lttng/utils.cpp                        | 2 +-
>  src/bin/lttng/utils.h                          | 2 +-
>  src/common/common.h                            | 2 +-
>  src/common/compat/poll.cpp                     | 2 +-
>  src/common/compat/poll.h                       | 2 +-
>  src/common/consumer/consumer-stream.cpp        | 2 +-
>  src/common/consumer/consumer-timer.h           | 2 +-
>  src/common/consumer/consumer.cpp               | 2 +-
>  src/common/consumer/consumer.h                 | 2 +-
>  src/common/defaults.cpp                        | 2 +-
>  src/common/defaults.h                          | 2 +-
>  src/common/error.h                             | 2 +-
>  src/common/futex.cpp                           | 2 +-
>  src/common/futex.h                             | 2 +-
>  src/common/hashtable/hashtable.cpp             | 2 +-
>  src/common/hashtable/hashtable.h               | 2 +-
>  src/common/hashtable/utils.cpp                 | 2 +-
>  src/common/hashtable/utils.h                   | 2 +-
>  src/common/kernel-consumer/kernel-consumer.cpp | 2 +-
>  src/common/kernel-consumer/kernel-consumer.h   | 2 +-
>  src/common/kernel-ctl/kernel-ctl.cpp           | 2 +-
>  src/common/kernel-ctl/kernel-ctl.h             | 2 +-
>  src/common/kernel-ctl/kernel-ioctl.h           | 2 +-
>  src/common/lttng-kernel-old.h                  | 3 +--
>  src/common/lttng-kernel.h                      | 3 +--
>  src/common/macros.h                            | 2 +-
>  src/common/runas.cpp                           | 2 +-
>  src/common/runas.h                             | 2 +-
>  src/common/sessiond-comm/sessiond-comm.cpp     | 2 +-
>  src/common/sessiond-comm/sessiond-comm.h       | 3 +--
>  src/common/shm.cpp                             | 2 +-
>  src/common/shm.h                               | 2 +-
>  src/common/spawn-viewer.cpp                    | 2 +-
>  src/common/unix.cpp                            | 2 +-
>  src/common/ust-consumer/ust-consumer.cpp       | 2 +-
>  src/common/ust-consumer/ust-consumer.h         | 2 +-
>  src/lib/lttng-ctl/lttng-ctl-health.cpp         | 2 +-
>  src/lib/lttng-ctl/lttng-ctl.cpp                | 2 +-
>  tests/unit/test_kernel_data.cpp                | 2 +-
>  tests/unit/test_session.cpp                    | 2 +-
>  tests/unit/test_ust_data.cpp                   | 2 +-
>  tests/unit/test_utils_parse_size_suffix.cpp    | 2 +-
>  tests/unit/test_utils_parse_time_suffix.cpp    | 2 +-
>  104 files changed, 105 insertions(+), 109 deletions(-)
>=20
> diff --git a/extras/lttng-bash_completion b/extras/lttng-bash_completion
> index 458748de1..f07ad9b85 100644
> --- a/extras/lttng-bash_completion
> +++ b/extras/lttng-bash_completion
> @@ -1,5 +1,5 @@
>  #
> -# Copyright (C) 2012 Simon Marchi <simon.marchi@polymtl.ca>A
> +# Copyright (C) 2012 EfficiOS Inc.
>  #
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> index 825b6682b..dbfe9a7db 100644
> --- a/include/lttng/lttng.h
> +++ b/include/lttng/lttng.h
> @@ -3,7 +3,7 @@
>   *
>   * Linux Trace Toolkit Control Library Header File
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: LGPL-2.1-only
>   *
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.cpp b/src/bin/lttng-=
consumerd/lttng-consumerd.cpp
> index dbcda885e..91617a11a 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.cpp
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.h b/src/bin/lttng-co=
nsumerd/lttng-consumerd.h
> index 354f7f3fa..833116ade 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.h
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.h
> @@ -1,6 +1,6 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-crash/lttng-crash.cpp b/src/bin/lttng-crash/lt=
tng-crash.cpp
> index 3f5ea3759..bee9c29b0 100644
> --- a/src/bin/lttng-crash/lttng-crash.cpp
> +++ b/src/bin/lttng-crash/lttng-crash.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/channel.cpp b/src/bin/lttng-sessiond/=
channel.cpp
> index 0f150972c..bfa6d4b49 100644
> --- a/src/bin/lttng-sessiond/channel.cpp
> +++ b/src/bin/lttng-sessiond/channel.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/channel.h b/src/bin/lttng-sessiond/ch=
annel.h
> index ef3100e25..b4ff9f4fd 100644
> --- a/src/bin/lttng-sessiond/channel.h
> +++ b/src/bin/lttng-sessiond/channel.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/client.cpp b/src/bin/lttng-sessiond/c=
lient.cpp
> index 154fa4a36..0820bca76 100644
> --- a/src/bin/lttng-sessiond/client.cpp
> +++ b/src/bin/lttng-sessiond/client.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/client.h b/src/bin/lttng-sessiond/cli=
ent.h
> index b80d56c71..0610d4509 100644
> --- a/src/bin/lttng-sessiond/client.h
> +++ b/src/bin/lttng-sessiond/client.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/context.cpp b/src/bin/lttng-sessiond/=
context.cpp
> index c8c892438..848d75043 100644
> --- a/src/bin/lttng-sessiond/context.cpp
> +++ b/src/bin/lttng-sessiond/context.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/context.h b/src/bin/lttng-sessiond/co=
ntext.h
> index 5caa19cb4..ed5fe2ca2 100644
> --- a/src/bin/lttng-sessiond/context.h
> +++ b/src/bin/lttng-sessiond/context.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/dispatch.cpp b/src/bin/lttng-sessiond=
/dispatch.cpp
> index b4092eb44..107e205c6 100644
> --- a/src/bin/lttng-sessiond/dispatch.cpp
> +++ b/src/bin/lttng-sessiond/dispatch.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/dispatch.h b/src/bin/lttng-sessiond/d=
ispatch.h
> index fe253dec0..7c8790e46 100644
> --- a/src/bin/lttng-sessiond/dispatch.h
> +++ b/src/bin/lttng-sessiond/dispatch.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/event.cpp b/src/bin/lttng-sessiond/ev=
ent.cpp
> index 284a8c472..d2e4589b2 100644
> --- a/src/bin/lttng-sessiond/event.cpp
> +++ b/src/bin/lttng-sessiond/event.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/event.h b/src/bin/lttng-sessiond/even=
t.h
> index 8849ee7cc..01be565b4 100644
> --- a/src/bin/lttng-sessiond/event.h
> +++ b/src/bin/lttng-sessiond/event.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/globals.cpp b/src/bin/lttng-sessiond/=
globals.cpp
> index b4cedf337..d07478316 100644
> --- a/src/bin/lttng-sessiond/globals.cpp
> +++ b/src/bin/lttng-sessiond/globals.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/kernel.cpp b/src/bin/lttng-sessiond/k=
ernel.cpp
> index 22ce819b5..cb2d649e7 100644
> --- a/src/bin/lttng-sessiond/kernel.cpp
> +++ b/src/bin/lttng-sessiond/kernel.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/kernel.h b/src/bin/lttng-sessiond/ker=
nel.h
> index 7af1928ea..5ecdad41f 100644
> --- a/src/bin/lttng-sessiond/kernel.h
> +++ b/src/bin/lttng-sessiond/kernel.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sess=
iond/lttng-sessiond.h
> index 8a82c45f7..65f4c372c 100644
> --- a/src/bin/lttng-sessiond/lttng-sessiond.h
> +++ b/src/bin/lttng-sessiond/lttng-sessiond.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2013 Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/main.cpp b/src/bin/lttng-sessiond/mai=
n.cpp
> index a676b257f..f622cfefa 100644
> --- a/src/bin/lttng-sessiond/main.cpp
> +++ b/src/bin/lttng-sessiond/main.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-apps.cpp b/src/bin/lttng-sessi=
ond/manage-apps.cpp
> index cff56cbad..588e83b6c 100644
> --- a/src/bin/lttng-sessiond/manage-apps.cpp
> +++ b/src/bin/lttng-sessiond/manage-apps.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-apps.h b/src/bin/lttng-session=
d/manage-apps.h
> index dad63ba38..3cd3b9c33 100644
> --- a/src/bin/lttng-sessiond/manage-apps.h
> +++ b/src/bin/lttng-sessiond/manage-apps.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-consumer.cpp b/src/bin/lttng-s=
essiond/manage-consumer.cpp
> index d7df6ce8f..cce48526e 100644
> --- a/src/bin/lttng-sessiond/manage-consumer.cpp
> +++ b/src/bin/lttng-sessiond/manage-consumer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-consumer.h b/src/bin/lttng-ses=
siond/manage-consumer.h
> index c99734d0b..16eb62dd9 100644
> --- a/src/bin/lttng-sessiond/manage-consumer.h
> +++ b/src/bin/lttng-sessiond/manage-consumer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-kernel.cpp b/src/bin/lttng-ses=
siond/manage-kernel.cpp
> index 2ffe60919..a789a0b29 100644
> --- a/src/bin/lttng-sessiond/manage-kernel.cpp
> +++ b/src/bin/lttng-sessiond/manage-kernel.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/manage-kernel.h b/src/bin/lttng-sessi=
ond/manage-kernel.h
> index 0670377a6..3be665811 100644
> --- a/src/bin/lttng-sessiond/manage-kernel.h
> +++ b/src/bin/lttng-sessiond/manage-kernel.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/process-utils.cpp b/src/bin/lttng-ses=
siond/process-utils.cpp
> index 2d629b547..d2e52172e 100644
> --- a/src/bin/lttng-sessiond/process-utils.cpp
> +++ b/src/bin/lttng-sessiond/process-utils.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/register.cpp b/src/bin/lttng-sessiond=
/register.cpp
> index 5bcc637b0..a20db57f6 100644
> --- a/src/bin/lttng-sessiond/register.cpp
> +++ b/src/bin/lttng-sessiond/register.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/register.h b/src/bin/lttng-sessiond/r=
egister.h
> index 7f5b08881..8b51ad48e 100644
> --- a/src/bin/lttng-sessiond/register.h
> +++ b/src/bin/lttng-sessiond/register.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/session.cpp b/src/bin/lttng-sessiond/=
session.cpp
> index 64fd19d04..fbf8ce55c 100644
> --- a/src/bin/lttng-sessiond/session.cpp
> +++ b/src/bin/lttng-sessiond/session.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/session.h b/src/bin/lttng-sessiond/se=
ssion.h
> index 1a31d3f0b..1a68d8e2f 100644
> --- a/src/bin/lttng-sessiond/session.h
> +++ b/src/bin/lttng-sessiond/session.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/thread-utils.cpp b/src/bin/lttng-sess=
iond/thread-utils.cpp
> index 1eb25eabe..2d8f8b789 100644
> --- a/src/bin/lttng-sessiond/thread-utils.cpp
> +++ b/src/bin/lttng-sessiond/thread-utils.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng-sessiond/trace-kernel.cpp b/src/bin/lttng-sess=
iond/trace-kernel.cpp
> index cf1455ee6..8d8c63e5d 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.cpp
> +++ b/src/bin/lttng-sessiond/trace-kernel.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/trace-kernel.h b/src/bin/lttng-sessio=
nd/trace-kernel.h
> index f6ad56c99..83608b235 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.h
> +++ b/src/bin/lttng-sessiond/trace-kernel.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/trace-ust.cpp b/src/bin/lttng-session=
d/trace-ust.cpp
> index 0f303bf03..ce85c3236 100644
> --- a/src/bin/lttng-sessiond/trace-ust.cpp
> +++ b/src/bin/lttng-sessiond/trace-ust.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/=
trace-ust.h
> index cc7cd332c..64d5105f8 100644
> --- a/src/bin/lttng-sessiond/trace-ust.h
> +++ b/src/bin/lttng-sessiond/trace-ust.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/ust-app.cpp b/src/bin/lttng-sessiond/=
ust-app.cpp
> index 54cd4dea6..f08e888c1 100644
> --- a/src/bin/lttng-sessiond/ust-app.cpp
> +++ b/src/bin/lttng-sessiond/ust-app.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/us=
t-app.h
> index 8d2d28986..0e2722e9e 100644
> --- a/src/bin/lttng-sessiond/ust-app.h
> +++ b/src/bin/lttng-sessiond/ust-app.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/ust-consumer.cpp b/src/bin/lttng-sess=
iond/ust-consumer.cpp
> index a68c5d96d..df9bb013a 100644
> --- a/src/bin/lttng-sessiond/ust-consumer.cpp
> +++ b/src/bin/lttng-sessiond/ust-consumer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/ust-consumer.h b/src/bin/lttng-sessio=
nd/ust-consumer.h
> index d4213e47c..5862c4837 100644
> --- a/src/bin/lttng-sessiond/ust-consumer.h
> +++ b/src/bin/lttng-sessiond/ust-consumer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng-sessiond/ust-ctl-internal.h b/src/bin/lttng-se=
ssiond/ust-ctl-internal.h
> index 610aa7f36..6bd21d8c6 100644
> --- a/src/bin/lttng-sessiond/ust-ctl-internal.h
> +++ b/src/bin/lttng-sessiond/ust-ctl-internal.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/ust-error-internal.h b/src/bin/lttng-=
sessiond/ust-error-internal.h
> index 3932fba18..a5f345faa 100644
> --- a/src/bin/lttng-sessiond/ust-error-internal.h
> +++ b/src/bin/lttng-sessiond/ust-error-internal.h
> @@ -1,6 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: LGPL-2.1-only
> diff --git a/src/bin/lttng-sessiond/utils.cpp b/src/bin/lttng-sessiond/ut=
ils.cpp
> index 6936a03f9..5b33a8df8 100644
> --- a/src/bin/lttng-sessiond/utils.cpp
> +++ b/src/bin/lttng-sessiond/utils.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng-sessiond/utils.h b/src/bin/lttng-sessiond/util=
s.h
> index ff8deaec4..b7e0a4fde 100644
> --- a/src/bin/lttng-sessiond/utils.h
> +++ b/src/bin/lttng-sessiond/utils.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/command.h b/src/bin/lttng/command.h
> index bf0045210..d2e1eff15 100644
> --- a/src/bin/lttng/command.h
> +++ b/src/bin/lttng/command.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/add_context.cpp b/src/bin/lttng/comma=
nds/add_context.cpp
> index 076fa83a4..6ea53709c 100644
> --- a/src/bin/lttng/commands/add_context.cpp
> +++ b/src/bin/lttng/commands/add_context.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng/commands/create.cpp b/src/bin/lttng/commands/c=
reate.cpp
> index b266c10a9..b46893d5e 100644
> --- a/src/bin/lttng/commands/create.cpp
> +++ b/src/bin/lttng/commands/create.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2019 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng/commands/destroy.cpp b/src/bin/lttng/commands/=
destroy.cpp
> index 78bbbaaad..2c51142bf 100644
> --- a/src/bin/lttng/commands/destroy.cpp
> +++ b/src/bin/lttng/commands/destroy.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/disable_channels.cpp b/src/bin/lttng/=
commands/disable_channels.cpp
> index cf9f20bb6..843fecd87 100644
> --- a/src/bin/lttng/commands/disable_channels.cpp
> +++ b/src/bin/lttng/commands/disable_channels.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/disable_events.cpp b/src/bin/lttng/co=
mmands/disable_events.cpp
> index 5ce36e50a..b269f138c 100644
> --- a/src/bin/lttng/commands/disable_events.cpp
> +++ b/src/bin/lttng/commands/disable_events.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/enable_channels.cpp b/src/bin/lttng/c=
ommands/enable_channels.cpp
> index 194ec541e..d62aa8656 100644
> --- a/src/bin/lttng/commands/enable_channels.cpp
> +++ b/src/bin/lttng/commands/enable_channels.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/enable_events.cpp b/src/bin/lttng/com=
mands/enable_events.cpp
> index 50854faaa..451a1eade 100644
> --- a/src/bin/lttng/commands/enable_events.cpp
> +++ b/src/bin/lttng/commands/enable_events.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/list.cpp b/src/bin/lttng/commands/lis=
t.cpp
> index 28063ebc9..9046c4658 100644
> --- a/src/bin/lttng/commands/list.cpp
> +++ b/src/bin/lttng/commands/list.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2020 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/bin/lttng/commands/set_session.cpp b/src/bin/lttng/comma=
nds/set_session.cpp
> index fb42d14d5..ed1b1640f 100644
> --- a/src/bin/lttng/commands/set_session.cpp
> +++ b/src/bin/lttng/commands/set_session.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/start.cpp b/src/bin/lttng/commands/st=
art.cpp
> index 7082e097d..69bd9221f 100644
> --- a/src/bin/lttng/commands/start.cpp
> +++ b/src/bin/lttng/commands/start.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/stop.cpp b/src/bin/lttng/commands/sto=
p.cpp
> index d69da40ab..ec7da898c 100644
> --- a/src/bin/lttng/commands/stop.cpp
> +++ b/src/bin/lttng/commands/stop.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/commands/track-untrack.cpp b/src/bin/lttng/com=
mands/track-untrack.cpp
> index 59b614423..7547f8b5d 100644
> --- a/src/bin/lttng/commands/track-untrack.cpp
> +++ b/src/bin/lttng/commands/track-untrack.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2015 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2020 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/bin/lttng/commands/version.cpp b/src/bin/lttng/commands/=
version.cpp
> index ccc7f6633..2126e20b7 100644
> --- a/src/bin/lttng/commands/version.cpp
> +++ b/src/bin/lttng/commands/version.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/conf.cpp b/src/bin/lttng/conf.cpp
> index e347c4b3a..4e22ca005 100644
> --- a/src/bin/lttng/conf.cpp
> +++ b/src/bin/lttng/conf.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/conf.h b/src/bin/lttng/conf.h
> index dcfce0571..e1260c772 100644
> --- a/src/bin/lttng/conf.h
> +++ b/src/bin/lttng/conf.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/lttng.cpp b/src/bin/lttng/lttng.cpp
> index af1d3f488..2b169cb0e 100644
> --- a/src/bin/lttng/lttng.cpp
> +++ b/src/bin/lttng/lttng.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/utils.cpp b/src/bin/lttng/utils.cpp
> index 6440ca7df..528318b2a 100644
> --- a/src/bin/lttng/utils.cpp
> +++ b/src/bin/lttng/utils.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
> index ba893edda..0cf01dbcd 100644
> --- a/src/bin/lttng/utils.h
> +++ b/src/bin/lttng/utils.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/common.h b/src/common/common.h
> index f2c2b1800..58b266953 100644
> --- a/src/common/common.h
> +++ b/src/common/common.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/compat/poll.cpp b/src/common/compat/poll.cpp
> index 4254ff8bb..ee4fc012c 100644
> --- a/src/common/compat/poll.cpp
> +++ b/src/common/compat/poll.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2019 Yannick Lamarre <ylamarre@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index e2a424abe..7a7842066 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/consumer/consumer-stream.cpp b/src/common/consume=
r/consumer-stream.cpp
> index f9807cb01..2dc3f002b 100644
> --- a/src/common/consumer/consumer-stream.cpp
> +++ b/src/common/consumer/consumer-stream.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2013 David Goulet <dgoulet@efficios.com>
>   *
> diff --git a/src/common/consumer/consumer-timer.h b/src/common/consumer/c=
onsumer-timer.h
> index 85751442f..bf1649cad 100644
> --- a/src/common/consumer/consumer-timer.h
> +++ b/src/common/consumer/consumer-timer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2012 David Goulet <dgoulet@efficios.com>
>   *
> diff --git a/src/common/consumer/consumer.cpp b/src/common/consumer/consu=
mer.cpp
> index fb5aeae7b..5730fd45c 100644
> --- a/src/common/consumer/consumer.cpp
> +++ b/src/common/consumer/consumer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2012 David Goulet <dgoulet@efficios.com>
>   *
> diff --git a/src/common/consumer/consumer.h b/src/common/consumer/consume=
r.h
> index 737f2a42c..4612fe819 100644
> --- a/src/common/consumer/consumer.h
> +++ b/src/common/consumer/consumer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2012 David Goulet <dgoulet@efficios.com>
>   * Copyright (C) 2018 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
> diff --git a/src/common/defaults.cpp b/src/common/defaults.cpp
> index 5ecb435bb..b295045b7 100644
> --- a/src/common/defaults.cpp
> +++ b/src/common/defaults.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 Simon Marchi <simon.marchi@polymtl.ca>
> + * Copyright (C) 2012 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 39b77470d..b889466fd 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2015 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/error.h b/src/common/error.h
> index bcbb51b16..b78801fb8 100644
> --- a/src/common/error.h
> +++ b/src/common/error.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/futex.cpp b/src/common/futex.cpp
> index d0f95abc8..3eadf096b 100644
> --- a/src/common/futex.cpp
> +++ b/src/common/futex.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/futex.h b/src/common/futex.h
> index 602be3186..e0faa9711 100644
> --- a/src/common/futex.h
> +++ b/src/common/futex.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/hashtable/hashtable.cpp b/src/common/hashtable/ha=
shtable.cpp
> index 7112debf2..5ae7f26e0 100644
> --- a/src/common/hashtable/hashtable.cpp
> +++ b/src/common/hashtable/hashtable.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/hashtable/hashtable.h b/src/common/hashtable/hash=
table.h
> index 3a515fdbd..e129ac5f8 100644
> --- a/src/common/hashtable/hashtable.h
> +++ b/src/common/hashtable/hashtable.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/hashtable/utils.cpp b/src/common/hashtable/utils.=
cpp
> index 3bc2b5e91..cc145e2e5 100644
> --- a/src/common/hashtable/utils.cpp
> +++ b/src/common/hashtable/utils.cpp
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2006 Bob Jenkins
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/hashtable/utils.h b/src/common/hashtable/utils.h
> index 992643931..edbf5e89b 100644
> --- a/src/common/hashtable/utils.h
> +++ b/src/common/hashtable/utils.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/kernel-consumer/kernel-consumer.cpp b/src/common/=
kernel-consumer/kernel-consumer.cpp
> index 8a6ef2a27..620ab8adf 100644
> --- a/src/common/kernel-consumer/kernel-consumer.cpp
> +++ b/src/common/kernel-consumer/kernel-consumer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2017 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/kernel-consumer/kernel-consumer.h b/src/common/ke=
rnel-consumer/kernel-consumer.h
> index 004becb0f..bd885f838 100644
> --- a/src/common/kernel-consumer/kernel-consumer.h
> +++ b/src/common/kernel-consumer/kernel-consumer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2017 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/kernel-ctl/kernel-ctl.cpp b/src/common/kernel-ctl=
/kernel-ctl.cpp
> index 4d59bdf29..8a43239ef 100644
> --- a/src/common/kernel-ctl/kernel-ctl.cpp
> +++ b/src/common/kernel-ctl/kernel-ctl.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/k=
ernel-ctl.h
> index e6805a983..f512e69f3 100644
> --- a/src/common/kernel-ctl/kernel-ctl.h
> +++ b/src/common/kernel-ctl/kernel-ctl.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl=
/kernel-ioctl.h
> index b9af57a6b..68bcc472c 100644
> --- a/src/common/kernel-ctl/kernel-ioctl.h
> +++ b/src/common/kernel-ctl/kernel-ioctl.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/lttng-kernel-old.h b/src/common/lttng-kernel-old.h
> index 14f9cb470..c36c63358 100644
> --- a/src/common/lttng-kernel-old.h
> +++ b/src/common/lttng-kernel-old.h
> @@ -1,7 +1,6 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
> index 82f242bbd..dd9db6f36 100644
> --- a/src/common/lttng-kernel.h
> +++ b/src/common/lttng-kernel.h
> @@ -1,7 +1,6 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/src/common/macros.h b/src/common/macros.h
> index 6ac24fa01..1c131db78 100644
> --- a/src/common/macros.h
> +++ b/src/common/macros.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/runas.cpp b/src/common/runas.cpp
> index 3c9eea8c3..98bbd10ff 100644
> --- a/src/common/runas.cpp
> +++ b/src/common/runas.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2019 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/runas.h b/src/common/runas.h
> index 406dfca22..4369d5c72 100644
> --- a/src/common/runas.h
> +++ b/src/common/runas.h
> @@ -2,7 +2,7 @@
>  #define _RUNAS_H
> =20
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/sessiond-comm/sessiond-comm.cpp b/src/common/sess=
iond-comm/sessiond-comm.cpp
> index 6a011b8b4..9a20fde25 100644
> --- a/src/common/sessiond-comm/sessiond-comm.cpp
> +++ b/src/common/sessiond-comm/sessiond-comm.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessio=
nd-comm/sessiond-comm.h
> index ba756f8f1..af9108764 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -1,6 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/shm.cpp b/src/common/shm.cpp
> index 99535c468..f1793d7a7 100644
> --- a/src/common/shm.cpp
> +++ b/src/common/shm.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/shm.h b/src/common/shm.h
> index d714506b8..76c81486b 100644
> --- a/src/common/shm.h
> +++ b/src/common/shm.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/spawn-viewer.cpp b/src/common/spawn-viewer.cpp
> index bcbc229a2..b9099bbd0 100644
> --- a/src/common/spawn-viewer.cpp
> +++ b/src/common/spawn-viewer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2020 Francis Deslauriers <francis.deslauriers@efficios.=
com>
>   *
> diff --git a/src/common/unix.cpp b/src/common/unix.cpp
> index 504970ea8..9c36c883e 100644
> --- a/src/common/unix.cpp
> +++ b/src/common/unix.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/common/ust-consumer/ust-consumer.cpp b/src/common/ust-co=
nsumer/ust-consumer.cpp
> index fb40f844e..591c58fc5 100644
> --- a/src/common/ust-consumer/ust-consumer.cpp
> +++ b/src/common/ust-consumer/ust-consumer.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (C) 2017 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
> diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-cons=
umer/ust-consumer.h
> index e2507a7f4..e481f0850 100644
> --- a/src/common/ust-consumer/ust-consumer.h
> +++ b/src/common/ust-consumer/ust-consumer.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
> diff --git a/src/lib/lttng-ctl/lttng-ctl-health.cpp b/src/lib/lttng-ctl/l=
ttng-ctl-health.cpp
> index 8a703b019..8981c7619 100644
> --- a/src/lib/lttng-ctl/lttng-ctl-health.cpp
> +++ b/src/lib/lttng-ctl/lttng-ctl-health.cpp
> @@ -3,7 +3,7 @@
>   *
>   * Linux Trace Toolkit Health Control Library
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
>   * SPDX-License-Identifier: LGPL-2.1-only
> diff --git a/src/lib/lttng-ctl/lttng-ctl.cpp b/src/lib/lttng-ctl/lttng-ct=
l.cpp
> index b7eaee260..684cf4669 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.cpp
> +++ b/src/lib/lttng-ctl/lttng-ctl.cpp
> @@ -3,7 +3,7 @@
>   *
>   * Linux Trace Toolkit Control Library
>   *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   * Copyright (C) 2016 J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.=
com>
>   *
>   * SPDX-License-Identifier: LGPL-2.1-only
> diff --git a/tests/unit/test_kernel_data.cpp b/tests/unit/test_kernel_dat=
a.cpp
> index 6f0ce872b..4451f65b7 100644
> --- a/tests/unit/test_kernel_data.cpp
> +++ b/tests/unit/test_kernel_data.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/tests/unit/test_session.cpp b/tests/unit/test_session.cpp
> index 4fc23791e..ee0549906 100644
> --- a/tests/unit/test_session.cpp
> +++ b/tests/unit/test_session.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/tests/unit/test_ust_data.cpp b/tests/unit/test_ust_data.cpp
> index f1b197ea9..b35576742 100644
> --- a/tests/unit/test_ust_data.cpp
> +++ b/tests/unit/test_ust_data.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/tests/unit/test_utils_parse_size_suffix.cpp b/tests/unit/tes=
t_utils_parse_size_suffix.cpp
> index ac6efa251..ac3e24b64 100644
> --- a/tests/unit/test_utils_parse_size_suffix.cpp
> +++ b/tests/unit/test_utils_parse_size_suffix.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2013 Simon Marchi <simon.marchi@polymtl.ca>
> + * Copyright (C) 2013 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> diff --git a/tests/unit/test_utils_parse_time_suffix.cpp b/tests/unit/tes=
t_utils_parse_time_suffix.cpp
> index 89fab12eb..71f52e426 100644
> --- a/tests/unit/test_utils_parse_time_suffix.cpp
> +++ b/tests/unit/test_utils_parse_time_suffix.cpp
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2015 Simon Marchi <simon.marchi@polymtl.ca>
> + * Copyright (C) 2015 EfficiOS Inc.
>   *
>   * SPDX-License-Identifier: GPL-2.0-only
>   *
> --=20
> 2.34.1
>=20

Signed-off-by: David Goulet <dgoulet@ev0ke.net>

--=20
s/rLfO0seSQ8fjaS+EqS675BgaLmFqhHovawELv2uZE=3D

--o7mlsa6dfbbotglc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEt0QX7d8irJ+ekPSRQuhqKhH0jTYFAmHlhOoACgkQQuhqKhH0
jTYemgf/en8WrUSKdop/vT1PXPHSWBflk6zDGhpoduhhiUv2rYza0DH2FIWZEhwT
jSNxwLGqgZVUbZV4xLRg1kOwqYeuCQoXqfkYs2B1U0W3Kxx9OXIdw2CFa/rTwhCv
xj0yPCN433FOT3LkUcmJfG5UCJ533pUyLj11Xfm9tyuLzvA347cypb9SYuP/hAkt
uxADyuxOx2Vq4MiGr3owzqbpdjdmwxZX6cdge8X+8cI6zDQ3T+0o1QAAEM6bUZTE
Cnq7GdmJwt2vmMdKbPQiFE31gDAm9qfQId588Naqb3hAEhudUVViq5Kls95QG1Vq
pyf4HoYON1t3udDM+wuBs2kEMc0oUA==
=ElML
-----END PGP SIGNATURE-----

--o7mlsa6dfbbotglc--

--===============0262509533580897659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0262509533580897659==--
