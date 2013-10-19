From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Sat, 19 Oct 2013 17:10:09 -0400
Message-ID: <20131019211009.GA83292__29333.8748779663$1382217070$gmane$org@helmut.local>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1VXdmi-0001up-8L
	for lttng-dev@lists.lttng.org; Sat, 19 Oct 2013 17:10:13 -0400
Content-Disposition: inline
In-Reply-To: <856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Hi Jon,
> 
> We've had a couple of user reports about lttng versions not working in Debian.
> 
> I'm looking at the current Debian sid, and here is the situation:
> 
> http://packages.debian.org/sid/lttng-tools : version 2.1.1-2
> http://packages.debian.org/sid/utils/ltt-bin : version 2.1.1-2
> http://packages.debian.org/sid/lttng-modules-dkms : version 2.3.0-1
> 
> Although it's possible that lttng-modules 2.3.x will work with lttng-tools
> 2.1.x, this combination of versions is unsupported. We require that
> ust/tools/modules be updated in locked step between minor versions (2.1 with
> 2.1, 2.2 with 2.2, and so on). Also, 2.1 is starting to be quite old: we're
> currently working on an upcoming 2.4, and the last version (2.3) provides lots
> of cool features including flight recorder tracing and snapshot support.

Yes, I do apologize for the current state.  My first priority was to resolve the
blocked testing migration for ust and lttng-tools.  My upload yesterday seems to
have resolved the last of the ust package issues, and so now I need only to
upload the remaining fixes for lttng-tools and the two should be eligible for
migration to testing.  I decided it would be easier to fix the migration problem
first, and then update all of the versions to 2.3.x - it makes perfect sense to
me as a packager, but I also see it's completely backwards from a user's
perspective.

Sid should have 2.3.x immediately and I will push these versions before the
weekend ends.

The migration is also very important to me, as Jessie will freeze soon.  I will
continue on that front after 2.3.x is in sid.

Does this sound like a reasonable plan?

-- 
Jon
