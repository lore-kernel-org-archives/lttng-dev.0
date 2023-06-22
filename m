Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31E8EB64D8
	for <lttng-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687458784;
	bh=ZtRmi1jxSpX7CReQ8qn3iI5OfS3qIctEIAlGzLVH/E0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=irr99NL+ecs/W5wm/DFWrSSbQ1/wijhAlXqMvVqOruMR6FQhDn8awhOh5t05CqWkK
	 ewG32BsUj4nQORLOzg/puYqqRNhMr57GrLHwmbwPcKjKUbL2ExPmsPbAVnyW37QuEu
	 9E1UaTjuVQpHN7TMiIOCsvM1HZWpZFJH3hlYd5LuOqTgNK+wnEnQ7pP0uqDhlm2cQy
	 xJFm/XZGNRMSlVpPvFcAg+ft1u012s5bUFYYC1ox0GWrcDTl12S9P6BLIt2XvS3TSx
	 9+QRXxS3xe6AEoy8jVArTK/m/+uUG6ReiLeyy74IXz4o/P/GZ18iHRGdUHGR9mWf2t
	 dujdWwfldP6vg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qn8BR6Tyfz20VS;
	Thu, 22 Jun 2023 14:33:03 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qn8BQ0Byjz20HQ
 for <lttng-dev@lists.lttng.org>; Thu, 22 Jun 2023 14:33:01 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B38E8618D3;
 Thu, 22 Jun 2023 18:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266A0C433C0;
 Thu, 22 Jun 2023 18:32:58 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id B25D5CE39F6; Thu, 22 Jun 2023 11:32:57 -0700 (PDT)
Date: Thu, 22 Jun 2023 11:32:57 -0700
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org
Message-ID: <105bad2a-9fed-4353-a434-a571ce9da7ac@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-3-odion@efficios.com>
 <c7834f41-c033-4c53-96e8-0ad728c2a285@paulmck-laptop>
 <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ffec193e-7060-3fe2-6526-c54e89e992e6@efficios.com>
Subject: Re: [lttng-dev] [PATCH 02/11] urcu/uatomic: Use atomic builtins if
 configured
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Jun 22, 2023 at 11:55:55AM -0400, Mathieu Desnoyers wrote:
> On 6/21/23 19:19, Paul E. McKenney wrote:
> [...]
> > > diff --git a/include/urcu/uatomic/builtins-generic.h b/include/urcu/uatomic/builtins-generic.h
> > > new file mode 100644
> > > index 0000000..8e6a9b5
> > > --- /dev/null
> > > +++ b/include/urcu/uatomic/builtins-generic.h
> > > @@ -0,0 +1,85 @@
> > > +/*
> > > + * urcu/uatomic/builtins-generic.h
> > > + *
> > > + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2.1 of the License, or (at your option) any later version.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Public
> > > + * License along with this library; if not, write to the Free Software
> > > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > > + */
> > > +
> > > +#ifndef _URCU_UATOMIC_BUILTINS_GENERIC_H
> > > +#define _URCU_UATOMIC_BUILTINS_GENERIC_H
> > > +
> > > +#include <urcu/system.h>
> > > +
> > > +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
> > > +
> > > +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
> > 
> > Does this lose the volatile semantics that the old-style definitions
> > had?
> > 
> 
> Yes.
> 
> [...]
> 
> > > +++ b/include/urcu/uatomic/builtins-x86.h
> > > @@ -0,0 +1,85 @@
> > > +/*
> > > + * urcu/uatomic/builtins-x86.h
> > > + *
> > > + * Copyright (c) 2023 Olivier Dion <odion@efficios.com>
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2.1 of the License, or (at your option) any later version.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Public
> > > + * License along with this library; if not, write to the Free Software
> > > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > > + */
> > > +
> > > +#ifndef _URCU_UATOMIC_BUILTINS_X86_H
> > > +#define _URCU_UATOMIC_BUILTINS_X86_H
> > > +
> > > +#include <urcu/system.h>
> > > +
> > > +#define uatomic_set(addr, v) __atomic_store_n(addr, v, __ATOMIC_RELAXED)
> > > +
> > > +#define uatomic_read(addr) __atomic_load_n(addr, __ATOMIC_RELAXED)
> > 
> > And same question here.
> 
> Yes, this opens interesting questions:
> 
> * what semantic do we want for uatomic_read/set ?
> 
> * what semantic do we want for CMM_LOAD_SHARED/CMM_STORE_SHARED ?
> 
> * do we want to allow load/store-shared to work on variables larger than a
> word ? (e.g. on a uint64_t on a 32-bit architecture, or on a structure)
> 
> * what are the guarantees of a volatile type ?
> 
> * what are the guarantees of a load/store relaxed in C11 ?
> 
> Does the delta between volatile and C11 relaxed guarantees matter ?
> 
> Is there an advantage to use C11 load/store relaxed over volatile ? Should
> we combine both C11 load/store _and_ volatile ? Should we use
> atomic_signal_fence instead ?

I suggest C11 volatile atomic load/store.  Load/store fusing is permitted
for non-volatile atomic loads and stores, and such fusing can ruin your
code's entire day.  ;-)

							Thanx, Paul
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
