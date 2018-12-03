From: Jeff Layton <jlayton@redhat.com>
Subject: Re: making liburcu and lttng coexist in a LGPL'ed
 program
Date: Mon, 03 Dec 2018 13:43:01 -0500
Message-ID: <8b9b51d11d375d18b1472937090541e3e657360f.camel__15728.958490263$1543862469$gmane$org@redhat.com>
References: <5fcdce0f9a2ed1f6e1337db191f3b97e872a8e2f.camel@redhat.com>
 <1340598393.14672.1543442803749.JavaMail.zimbra@efficios.com>
 <30865b2cf91a657a0b599b7853201ef372585ee2.camel@redhat.com>
 <1370084463.18476.1543861523124.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nkV7auHSA5SjMt12/XI9"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by lists.lttng.org (Postfix) with ESMTPS id 437v546PPHzy4N
 for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2018 13:43:04 -0500 (EST)
Received: by mail-qk1-f193.google.com with SMTP id q70so8001747qkh.6
 for <lttng-dev@lists.lttng.org>; Mon, 03 Dec 2018 10:43:04 -0800 (PST)
In-Reply-To: <1370084463.18476.1543861523124.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, =?ISO-8859-1?Q?Genevi=E8ve?= Bastien <genevieve.bastien@polymtl.ca>, Thomas Serlin <tserlin@redhat.com>, devel <devel@lists.nfs-ganesha.org>
List-Id: lttng-dev@lists.lttng.org


--=-nkV7auHSA5SjMt12/XI9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-12-03 at 13:25 -0500, Mathieu Desnoyers wrote:
> ----- On Dec 3, 2018, at 12:58 PM, Jeff Layton jlayton@redhat.com wrote:
> 
> > On Wed, 2018-11-28 at 17:06 -0500, Mathieu Desnoyers wrote:
> > > ----- On Nov 27, 2018, at 1:17 PM, Jeff Layton jlayton@redhat.com wrote:
> > > 
> > > > The nfs-ganesha project has used lttng for quite some time to handle
> > > > tracing. Recently though, we decided to start building liburcu in as a
> > > > mandatory component, with an eye toward using it in certain areas.
> > > > 
> > > > Before this change, the code linked in liburcu-bp directly, but now we
> > > > just use liburcu. Unfortunately, when we enable tracepoints in the build
> > > > now, we get errors like this at link time:
> > > > 
> > > > --------------------8<----------------
> > > > [ 96%] Linking C executable ganesha.nfsd
> > > > /usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to
> > > > symbol 'rcu_gp_bp'
> > > > /usr/bin/ld: //usr/lib64/liburcu-bp.so.6: error adding symbols: DSO missing from
> > > > command line
> > > > collect2: error: ld returned 1 exit status
> > > > make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:308:
> > > > MainNFSD/ganesha.nfsd] Error 1
> > > > make[1]: *** [CMakeFiles/Makefile2:2740:
> > > > MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
> > > > make: *** [Makefile:152: all] Error 2
> > > > --------------------8<----------------
> > > > 
> > > > nfs-ganesha defines _LGPL_SOURCE, and that makes lttng use the
> > > > redefinitions in tracepoint-rcu.h. If I disable _LGPL_SOURCE, it all
> > > > builds as expected.
> > > > 
> > > > I found a similar bug here:
> > > > 
> > > >    https://bugs.lttng.org/issues/1156
> > > > 
> > > > Any thoughts on the right fix for this? We'd like to eat our cake and
> > > > have it too, so that we can have _LGPL_SOURCE defined, lttng enabled,
> > > > and the urcu flavor be determined at runtime.
> > > 
> > > Hi!
> > > 
> > > It's great to hear that feedback. Indeed you are not the first one
> > > to hit this unfortunate limitation of liburcu API.
> > > 
> > > The use-case involves using many liburcu flavors within the same
> > > compile unit _with_ _LGPL_SOURCE defined. All the tricks done
> > > in urcu/map/*.h to map all flavors to a single API conflict
> > > with that use-case. And the fact that the "mb", memb", and
> > > signal flavors all share the same header prevents this
> > > even further. This becomes a real issue when trying to use
> > > the lttng-ust tracer instrumentation (which includes urcu-bp.h)
> > > along with other liburcu flavors in a compile unit.
> > > 
> > > So, I took the day to hack something out: beware, it's a complete
> > > overhaul of the liburcu tree. You can try it out in this private
> > > development branch:
> > > 
> > > https://github.com/compudj/userspace-rcu-dev/tree/multiflavor
> > > 
> > > Note: don't even try to follow the git commit history at the
> > > moment, this will need editing. ;)
> > > 
> > > A new unit test shows how it works:
> > > 
> > > https://github.com/compudj/userspace-rcu-dev/blob/multiflavor/tests/unit/test_urcu_multiflavor_single_unit.c
> > > 
> > > And while I was there, I did a lot of namespacing cleanups for the
> > > APIs, so we'll _definitely_ need to bump the major soname for this.
> > > However, I'm keeping the main use-cases of the API backward compatible
> > > (those which relied on the API mapping). Here is a dev branch of
> > > lttng-ust adapting to those API changes:
> > > 
> > > https://github.com/compudj/lttng-ust-dev/tree/urcu-multiflavor
> > > 
> > > Those who want to be able to use many liburcu flavors in a single
> > > compile unit would need to define URCU_NO_API_MAP, and use each flavor
> > > namespace directly, as done in the new unit test. I'm not particularly
> > > fond of the URCU_NO_API_MAP name. We could perhaps name it "URCU_MULTI_FLAVOR"
> > > or something else...
> 
> By the way, with the updated liburcu tree, there is no more need to
> define URCU_NO_API_MAP.
> 
> > > Please try it out and let me know how it goes.
> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > 
> > Thanks Mathieu,
> > 
> > Sorry for the delay, but this was rather difficult to test. I ended up
> > building a userspace-rcu package from this tree, but was unable to
> > build lttng-ust as a package from your tree, and so had to just do a
> > make/make install of it on the build host. Ditto for lttng-tools.
> 
> You will need lttng-ust from this tree:
> 
> https://github.com/compudj/lttng-ust-dev/tree/urcu-multiflavor
> 
> to build against the liburcu branch. This is causing your missing symbol
> error.
> 
> Thanks,
> 
> Mathieu
> 

That's the branch I'm using [1]. I basically checked out that branch,
and did: 

configure --prefix=/usr
make
make install 

...and then did the same with lttng-tools (which ganesha also
requires). After that, I pulled down nfs-ganesha tree, checked out the
"next" branch and tried to build it, and got that same error.

It's certainly possible that we don't have something right in nfs-
ganesha that's causing this.

[1]: note that your lttng-ust branch also requires the attached patch.
Feel free to squash it in w/o attribution.

> With all of that, I reran the ganesha build and got the same error:
> > 
> > [ 97%] Linking C executable ganesha.nfsd
> > /usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to
> > symbol 'urcu_bp_register'
> > /usr/bin/ld: //usr/lib64/liburcu-bp.so.7: error adding symbols: DSO missing from
> > command line
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:288:
> > MainNFSD/ganesha.nfsd] Error 1
> > make[1]: *** [CMakeFiles/Makefile2:2396:
> > MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
> > make: *** [Makefile:152: all] Error 2
> > 
> > Should we be passing in both -lurcu and -lurcu-bp on the link here?
> > --
> > Jeff Layton <jlayton@redhat.com>
-- 
Jeff Layton <jlayton@redhat.com>

--=-nkV7auHSA5SjMt12/XI9
Content-Disposition: attachment; filename="0001-Fix-configure.ac.patch"
Content-Type: text/x-patch; name="0001-Fix-configure.ac.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyMWJkZjQ1YTQzYzhkNjZkZGQyNWI0MzQ4YmNhOWYzM2Y3NDdkNzRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpEYXRl
OiBNb24sIDMgRGVjIDIwMTggMTE6Mjk6MDUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBGaXggY29u
ZmlndXJlLmFjCgpTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3Jn
PgotLS0KIGNvbmZpZ3VyZS5hYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1
cmUuYWMKaW5kZXggYTNlMWUyMzhjZTQ3Li42NWUwMjVhNDJlMjQgMTAwNjQ0Ci0tLSBhL2NvbmZp
Z3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAgLTI3NSwxMCArMjc1LDEwIEBAIEFDX0NPTVBJ
TEVfSUZFTFNFKFtBQ19MQU5HX1NPVVJDRShbWwogXSkKIAogIyB1cmN1IC0gY2hlY2sgdGhhdCBV
UkNVIGxpYiBpcyBhdmFpbGFibGUgdG8gY29tcGlsYXRpb24KLUFDX0NIRUNLX0xJQihbdXJjdS1i
cF0sIFtzeW5jaHJvbml6ZV9yY3VfYnBdLCBbXSwgW0FDX01TR19FUlJPUihbQ2Fubm90IGZpbmQg
bGlidXJjdS1icCBsaWIuIFVzZSBbTERGTEFHU109LUxkaXIgdG8gc3BlY2lmeSBpdHMgbG9jYXRp
b24uXSldKQorQUNfQ0hFQ0tfTElCKFt1cmN1LWJwXSwgW3VyY3VfYnBfc3luY2hyb25pemVfcmN1
XSwgW10sIFtBQ19NU0dfRVJST1IoW0Nhbm5vdCBmaW5kIGxpYnVyY3UtYnAgbGliLiBVc2UgW0xE
RkxBR1NdPS1MZGlyIHRvIHNwZWNpZnkgaXRzIGxvY2F0aW9uLl0pXSkKIAogIyB1cmN1IC0gY2hl
Y2sgdGhhdCBVUkNVIGxpYiBpcyBhdCBsZWFzdCB2ZXJzaW9uIDAuNgotQUNfQ0hFQ0tfTElCKFt1
cmN1LWJwXSwgW2NhbGxfcmN1X2JwXSwgW10sIFtBQ19NU0dfRVJST1IoW2xpYnVyY3UgMC42IG9y
IG5ld2VyIGlzIG5lZWRlZCwgcGxlYXNlIHVwZGF0ZSB5b3VyIHZlcnNpb24gb3IgdXNlIFtMREZM
QUdTXT0tTGRpciB0byBzcGVjaWZ5IHRoZSByaWdodCBsb2NhdGlvbi5dKV0pCitBQ19DSEVDS19M
SUIoW3VyY3UtYnBdLCBbdXJjdV9icF9jYWxsX3JjdV0sIFtdLCBbQUNfTVNHX0VSUk9SKFtsaWJ1
cmN1IDAuNiBvciBuZXdlciBpcyBuZWVkZWQsIHBsZWFzZSB1cGRhdGUgeW91ciB2ZXJzaW9uIG9y
IHVzZSBbTERGTEFHU109LUxkaXIgdG8gc3BlY2lmeSB0aGUgcmlnaHQgbG9jYXRpb24uXSldKQog
CiAjIG51bWEuaCBpbnRlZ3JhdGlvbgogQVNfSUYoW3Rlc3QgIngkTk9fTlVNQSIgPSAieDEiXSxb
Ci0tIAoyLjE5LjIKCg==


--=-nkV7auHSA5SjMt12/XI9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=-nkV7auHSA5SjMt12/XI9--
