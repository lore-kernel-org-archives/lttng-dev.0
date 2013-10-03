From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Thu, 03 Oct 2013 11:54:15 -0400
Message-ID: <524D9327.5080704__43058.5359376439$1380815794$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679582B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VRlFV-0000dr-Fg
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 11:55:38 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679582B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

>> The Debian/Ubuntu packages for liblttng-ust and liburcu are multiarch-enabled, so you can install the :i386 and :amd64 versions in
>> parallel. That way they will be tracked by the package manager, and won't "linger around".
>    Except that the Ubuntu LTTng packages are hopelessly behind right now.  I wanted to do everything with the 2.3.0 release.

The packages from the official repo are often behind, yes. But we have
an Ubuntu PPA which follows the stable releases:
https://launchpad.net/~lttng/+archive/ppa

It's updated daily with the contents of the stable-* git branches.

>    On a different note, why does LTTng have 32- and 64-bit consumers anyway?  The only possible difference between a 32-bit tracer and a 
> 64-bit tracer is that the latter could generate event record fields that are 64-bit longs and floats, while the former cannot (but will never 
> have to, since the application it is tracing won't have such beasts anyway).  So the 64-bit consumer should be backward compatible with the
> 32-bit consumer, because it deals with a super-set of the 32-bit consumer requirements.  If this were the only difference, LTTng would not
> need a separate 32-bit consumer daemon.  Is there some sort of context-switching overhead associated with a 64-bit daemon accessing a
> buffer that exists in a 32-bit process context?  The performance gain would justify the existence of a 32-bit consumer, I suppose.

The consumer shares memory space with the traced process, so they have
to use the same ABI. If they talked only through let's say a pipe, that
wouldn't be necessary, but performance would indeed be much worse.


Cheers,
Alex
