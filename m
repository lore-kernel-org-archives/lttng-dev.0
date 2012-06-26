From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space
Date: Tue, 26 Jun 2012 13:01:09 -0400
Message-ID: <20120626170109.GC23255__34333.6561265916$1340730106$gmane$org@Krystal>
References: <1338938654-16515-1-git-send-email-francis.giraldeau@gmail.com>
	<20120626064016.GD11952@Krystal> <4FE9CC91.5030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjZ8Z-0002xR-6X
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 13:01:11 -0400
Content-Disposition: inline
In-Reply-To: <4FE9CC91.5030301@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-06-26 08:40, Mathieu Desnoyers a =E9crit :
> >> +/*
> >> + * lttng_uevent_set_handler - set handler functions for uevent
> >> + *
> >> + * Access to handler code is protected with rwlock in order to
> >> + * prevent the optional module to be removed while in use.
> >> + */
> >> +
> >> +void lttng_uevent_set_handler(write_ops_t handler)
> >> +{
> >> +	write_lock(&uevent_rwlock);
> > =

> > write lock not necessary.
> > =

> > if (!lttng_uevent_set_handler)
> >   release refcount in prior handler's module.
> > =

> > then:
> > take a refcount on the module that contains the handler address.
> > (explicit)
> =

> =

> The function now looks like this:
> =

> void lttng_uevent_set_handler(struct file_operations *fops)
> {
> 	if (lttng_uevent_handler) {
> 		module_put(lttng_uevent_handler->owner);
> 	}
> 	if (fops && try_module_get(fops->owner)) {
> 		lttng_uevent_handler =3D fops;
> 		return;
> 	}
> 	lttng_uevent_handler =3D NULL;
> 	return;
> }
> =

> The problem with this approach is that lttng_uevent can't be unloaded
> anymore:
> =

>   rmmod lttng_uevent
>   ERROR: Module lttng_uevent is in use
> =

> The module lttng_uevent can't be unloaded without unloading the module
> lttng_tracer. The function module_exit of lttng_uevent is never called,
> such that there is a chicken-and-egg situation. This problem was solved
> by using rwlock to access the handler pointer. In the rare event when
> unload module would occur while a trace event is recorded, the write
> lock was preventing to change the handler pointer while it's in use. But
> maybe there is another way to do it?

Good point, circular dependency on the destructor is not good, because
there is no way to unload the module.

Another way to do it is to use RCU. module unload contains a
synchronize_rcu() call, so you can protect your handler with:

/* Using RCU to protect against module removal */
rcu_read_lock();
handler =3D rcu_dereference(lttng_uevent_handler);
ret =3D handler(...)));
rcu_read_unlock;
return ret;

Thanks,

Mathieu

> =

> Thanks!
> =

> Francis Giraldeau
> =




> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
