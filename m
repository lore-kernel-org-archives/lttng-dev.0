From: Jonathan Rajotte-Julien <jonathan.rajotte-julien-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] lttng-modules: Backport patches to fix
 compilation failures since kernel v5.1
Date: Wed, 12 Jun 2019 10:52:36 -0400
Message-ID: <20190612145236.GA27613@joraj-alpa>
References: <1560243834-266906-1-git-send-email-zhe.he@windriver.com>
	<be27377cd254f6b314185702300d051d20fb7c28.camel@linuxfoundation.org>
	<20190612105114.GA23143@localhost>
	<1859381600.42862.1560337102909.JavaMail.zimbra@efficios.com>
	<0ea3a599-7adb-a001-dbdd-3843d0fa8b6e@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0ea3a599-7adb-a001-dbdd-3843d0fa8b6e-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>, lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Jeremie Galarneau <jgalar-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

> > Please don't base distributions on -rc tags. They are not meant for this.
> >
> > We always integrate support for newer kernel versions instrumentation back
> > into our current stable release. So as soon as 5.2 final comes out, we will
> > release a 2.10.x version including support for it in lttng-modules.
> 
> I'm one of the people who need to use lttng-modules on rc kernel.

If so, please use a git based recipe building the HEAD of the latest released
stable branch (stable-2.10 currently since 2.11 is in currently in the RC
stage). If you have problem, report them on our mailing list [1] or our bug
tracker [2]. We have extensive CI jobs for lttng-modules against the vanilla
kernel [3] and other usual suspects [4]. We normally catch those problems
quite quickly. Keep in mind that in no way should a production image be built
with a non tagged release.

As for the oe-core recipe, please send us a quick email to let us know, patch
level releases are cheap. Keep in mind that we are chasing a moving target
here.

To add to Mathieu statement, not only do we integrate support for newer kernels into
the current stable branch but also in all the supported stable branch when
possible. The supported stable release are normally the 3 latest minor-level releases.
Currently this set is : 2.8, 2.9, 2.10 .

[1] https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
[2] https://bugs.lttng.org/
[3] An example of such job running: https://ci.lttng.org/view/LTTng-modules/job/lttng-modules_master_build-vanilla/648/console
    This job validate that lttng-modules master builds against the following vanilla kernel tags. We have
    similar jobs for master, stable 2.11, stable 2.10, stable 2.9, stable 2.10 lttng-modules branch.
      v3.0.101
      v3.1.10
      v3.2.102
      v3.3.8
      v3.4.113
      v3.5.7
      v3.6.11
      v3.7.10
      v3.8.13
      v3.9.11
      v3.10.108
      v3.11.10
      v3.12.74
      v3.13.11
      v3.14.79
      v3.15.10
      v3.16.68
      v3.17.8
      v3.18.140
      v3.19.8
      v4.0.9
      v4.1.52
      v4.2.8
      v4.3.6
      v4.4.181
      v4.5.7
      v4.6.7
      v4.7.10
      v4.8.17
      v4.9.181
      v4.10.17
      v4.11.12
      v4.12.14
      v4.13.16
      v4.14.125
      v4.15.18
      v4.16.18
      v4.17.19
      v4.18.20
      v4.19.50
      v4.20.17
      v5.0.21
      v5.1.9
      v5.2-rc4
[4] https://ci.lttng.org/view/LTTng-modules/

-- 
Jonathan Rajotte-Julien
EfficiOS
-- 
