From: David Goulet <dgoulet@efficios.com>
Subject: Re: Question about lttng daemons
Date: Thu, 26 Jul 2012 10:54:55 -0400
Message-ID: <50115A3F.5010402__25422.9435035542$1343314564$gmane$org@efficios.com>
References: <5010FFA8.9000706@emc.com> <5011570E.3060200@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SuPSt-00044C-F5
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 10:54:59 -0400
In-Reply-To: <5011570E.3060200@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi guys,

Alexandre Montplaisir:
> Hi,
> 
> I can answer your first question ;)
> 
> 
> On 12-07-26 04:28 AM, changz wrote:
>> Hi all,
>> 
>> Is that possible to launch lttng daemons as a system service?
>> i.e. we can start/stop/restart it like the services under
>> /etc/init.d.
> 
> Absolutely. Note that you only need to auto-start the
> lttng-sessiond. The consumerd daemons get started automatically by
> the sessiond when trace sessions are created. This is a nice way to
> start a root session daemon at boot time, which then allows users
> in the "tracing" group to use the kernel tracer without being root
> themselves.
> 
> We don't ship an example in the source tree, since this is usually 
> distro-specific, but for reference you can look at the Upstart
> script that is available in the Ubuntu package: 
> http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/lttng-tools/quantal/view/head:/debian/lttng-tools.lttng-sessiond.upstart
>
> 
We could maybe provide this upstart script in extras/ ?

> 
> Alex
> 
>> Another concern is if here is a way to recover or continue the 
>> dataflow once the daemons get crashed. I hope some vital trace
>> info can be still kept even if daemon crashes.

Right now we *don't* have this kind of feature. We are hoping someday
that we'll be able to dump the state or configuration of tracing
session onto disk that can be later on loaded by another daemon for
instance.

However, we do offer (upstream master not yet released) a health check
API call which return the health status of the session daemon
(lttng-sessiond). So for now, you can at least monitor the daemon but
still no mechanism to save tracing session info.

Please note that if the daemon crashes, the tracers are NOT impacted
meaning that user space applications don't crash, they will simply
continue their way without tracing and the kernel tracing will also stop.

Cheers!
David

>> 
>> BR zheng
>> 
>> 
>> 
>> _______________________________________________ lttng-dev mailing
>> list lttng-dev@lists.lttng.org 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQEVo8AAoJEELoaioR9I029xgIAMnnjcKFJHjTXpTECXIWToHr
8YcksDEowDiIrqzIJiDIWisxgCs285QuLaA+NMYb7zlyQ9MLSq9JcmFNfNW5s0aG
MmCSDpq50gg+g7OZH7wKMrEl+te3g8Cu3ZEOktHG8R+LCEExiawVockuYFHBmfL9
rXOa3imt4rUn2LW8428JvSwbkQxS6kknR12GH594YOqPxrGxTBvSlTukBCECPREj
Ng2s1DMCcGHav1vXo1+W1rftv+n85C9Uih369ay+J8dISU5almSJxbH9E/QWhF0u
2ghSkoit2+09Vr6xMGKUcEuAZkJ+Vu/BZB4SybwVZay8df3GZ1Fkfe1IsW3/Mnk=
=OeB0
-----END PGP SIGNATURE-----
