From: Jeff Layton <jlayton@redhat.com>
Subject: Re: making liburcu and lttng coexist in a LGPL'ed
 program
Date: Mon, 03 Dec 2018 12:58:31 -0500
Message-ID: <30865b2cf91a657a0b599b7853201ef372585ee2.camel__18970.5333243639$1543859798$gmane$org@redhat.com>
References: <5fcdce0f9a2ed1f6e1337db191f3b97e872a8e2f.camel@redhat.com>
 <1340598393.14672.1543442803749.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 437t5k4RkLzxy1
 for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2018 12:58:34 -0500 (EST)
Received: by mail-qt1-f195.google.com with SMTP id n32so14792972qte.11
 for <lttng-dev@lists.lttng.org>; Mon, 03 Dec 2018 09:58:34 -0800 (PST)
In-Reply-To: <1340598393.14672.1543442803749.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, =?ISO-8859-1?Q?Genevi=E8ve?= Bastien <genevieve.bastien@polymtl.ca>, Thomas Serlin <tserlin@redhat.com>, devel@lists.nfs-ganesha.org
List-Id: lttng-dev@lists.lttng.org

On Wed, 2018-11-28 at 17:06 -0500, Mathieu Desnoyers wrote:
> ----- On Nov 27, 2018, at 1:17 PM, Jeff Layton jlayton@redhat.com wrote:
> 
> > The nfs-ganesha project has used lttng for quite some time to handle
> > tracing. Recently though, we decided to start building liburcu in as a
> > mandatory component, with an eye toward using it in certain areas.
> > 
> > Before this change, the code linked in liburcu-bp directly, but now we
> > just use liburcu. Unfortunately, when we enable tracepoints in the build
> > now, we get errors like this at link time:
> > 
> > --------------------8<----------------
> > [ 96%] Linking C executable ganesha.nfsd
> > /usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to
> > symbol 'rcu_gp_bp'
> > /usr/bin/ld: //usr/lib64/liburcu-bp.so.6: error adding symbols: DSO missing from
> > command line
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:308:
> > MainNFSD/ganesha.nfsd] Error 1
> > make[1]: *** [CMakeFiles/Makefile2:2740:
> > MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
> > make: *** [Makefile:152: all] Error 2
> > --------------------8<----------------
> > 
> > nfs-ganesha defines _LGPL_SOURCE, and that makes lttng use the
> > redefinitions in tracepoint-rcu.h. If I disable _LGPL_SOURCE, it all
> > builds as expected.
> > 
> > I found a similar bug here:
> > 
> >    https://bugs.lttng.org/issues/1156
> > 
> > Any thoughts on the right fix for this? We'd like to eat our cake and
> > have it too, so that we can have _LGPL_SOURCE defined, lttng enabled,
> > and the urcu flavor be determined at runtime.
> 
> Hi!
> 
> It's great to hear that feedback. Indeed you are not the first one
> to hit this unfortunate limitation of liburcu API.
> 
> The use-case involves using many liburcu flavors within the same
> compile unit _with_ _LGPL_SOURCE defined. All the tricks done
> in urcu/map/*.h to map all flavors to a single API conflict
> with that use-case. And the fact that the "mb", memb", and
> signal flavors all share the same header prevents this
> even further. This becomes a real issue when trying to use
> the lttng-ust tracer instrumentation (which includes urcu-bp.h)
> along with other liburcu flavors in a compile unit.
> 
> So, I took the day to hack something out: beware, it's a complete
> overhaul of the liburcu tree. You can try it out in this private
> development branch:
> 
> https://github.com/compudj/userspace-rcu-dev/tree/multiflavor
> 
> Note: don't even try to follow the git commit history at the
> moment, this will need editing. ;)
> 
> A new unit test shows how it works:
> 
> https://github.com/compudj/userspace-rcu-dev/blob/multiflavor/tests/unit/test_urcu_multiflavor_single_unit.c
> 
> And while I was there, I did a lot of namespacing cleanups for the
> APIs, so we'll _definitely_ need to bump the major soname for this.
> However, I'm keeping the main use-cases of the API backward compatible
> (those which relied on the API mapping). Here is a dev branch of
> lttng-ust adapting to those API changes:
> 
> https://github.com/compudj/lttng-ust-dev/tree/urcu-multiflavor
> 
> Those who want to be able to use many liburcu flavors in a single
> compile unit would need to define URCU_NO_API_MAP, and use each flavor
> namespace directly, as done in the new unit test. I'm not particularly
> fond of the URCU_NO_API_MAP name. We could perhaps name it "URCU_MULTI_FLAVOR"
> or something else...
> 
> Please try it out and let me know how it goes.
> 
> Thanks,
> 
> Mathieu
> 

Thanks Mathieu,

Sorry for the delay, but this was rather difficult to test. I ended up
building a userspace-rcu package from this tree, but was unable to
build lttng-ust as a package from your tree, and so had to just do a
make/make install of it on the build host. Ditto for lttng-tools.

With all of that, I reran the ganesha build and got the same error:

[ 97%] Linking C executable ganesha.nfsd
/usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to symbol 'urcu_bp_register'
/usr/bin/ld: //usr/lib64/liburcu-bp.so.7: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:288: MainNFSD/ganesha.nfsd] Error 1
make[1]: *** [CMakeFiles/Makefile2:2396: MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
make: *** [Makefile:152: all] Error 2

Should we be passing in both -lurcu and -lurcu-bp on the link here?
-- 
Jeff Layton <jlayton@redhat.com>
