From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Release strategy
Date: Wed, 24 Jul 2013 10:36:49 -0400
Message-ID: <CA+jJMxsPH9s=OBEcD4+_92aoiDw6_EdePTZJMA9VtLPSrVzh_w__28925.4173556857$1374676671$gmane$org@mail.gmail.com>
References: <51EEDF15.4090300@ericsson.com>
	<CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V20BT-0006sp-Up
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 10:37:02 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so485419wgh.17
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 07:36:49 -0700 (PDT)
In-Reply-To: <CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Jul 23, 2013 at 11:30 PM, Christian Babeux
<christian.babeux@efficios.com> wrote:
> Hi Matthew,
>
> You certainly raise valid and interesting questions about our release
> process. Here how I would categorize these questions:
>
> 1) Branching policy (when do we branch master? after the first release
> candidate or after a final release?)
>
> 2) Release roadmap (when the next release is planned? what does it contai=
n?)
>
> 3) Tentative release dates
>
> For 1), the current way we are doing things is that during a release
> candidate phase for a new stable release, a complete code freeze is in
> effect e.g. only bug fixes will be merged until a stable release is
> out. Normally, after multiple release candidates, master is branched
> into a stable branch and the final official stable release is created
> from that branch.
>
> This could potentially cause troubles for contributors, e.g. posting a
> set of patches and getting no response or waiting for merge if a
> release candidate cycle is in effect. Any ideas/suggestions on how we
> could improve this?
>

We should create a separate branch at the first release candidate and
stabilize it until the official release. The feature freeze would then
only apply to that branch while invasive changes could be merged in
master at all times. It would certainly make it easier on occasional
contributors that may not be aware of the release schedule (at the
expense of the maintainers' sanity...).

> For 2), the release roadmap is available at [1]. The roadmap is kind
> of a mess right now because bugs are assigned to older stable releases
> giving the wrong impression that some stable releases are way late.
>
> We would need a way to distinguish between bugs on already released
> versions and features targeting future versions. Perhaps something
> like [2-3] could be promising?
>

Disciplining ourselves in opening Features with reasonable target
dates on the bug tracker may be enough to make the current "Roadmap"
plug-in useful.

> For 3), I would try to put tentative release dates on the roadmap on
> Redmine or on a wiki article similar to [4]?
>

I'd prefer using the roadmap functionality. I'm afraid the wiki won't
be maintained as releases slip.

> Another point that you did not mention is how we plan minor releases.
> I think we will need to define a clear policy for minor releases
> sooner than later because it is becoming quite painful to support
> three codebases (modules, ust, tools) with three stable branches...
> Perhaps in another thread?
>
> On a more general note, I think clear communication is the key here.
> I'm wondering if a monthly summary of the development activities on
> LTTng and related projects could be interesting for the community?
> Content example:
>
> - What have we accomplished in the past month.
> - What we are planning for the following month.
> - Release status (next stable tentative release dates, planned minor
> releases, etc.)
> - Etc.
>

Sounds good. It would also be a great opportunity to structure
discussions around the planning.

Regards,
J=E9r=E9mie

> Any ideas/suggestions/constructive criticism on how we can improve our
> release process are quite welcome!
>
> Thanks,
>
> Christian
>
> [1] - http://bugs.lttng.org/projects/lttng/roadmap
> [2] - http://www.redmine.org/plugins/advanced_roadmap
> [3] - http://www.redmine.org/plugins/redmine_milestones
> [4] - https://www.gnu.org/software/gdb/schedule/
>
> On Tue, Jul 23, 2013 at 3:52 PM, Matthew Khouzam
> <matthew.khouzam@ericsson.com> wrote:
>> Hello tracing rangers,
>>
>> I am a bit confused about the whole release cycle system.
>>
>> If you guys are in RC, I have a cool feature I was working on, where do
>> I put it?
>>
>> When are releases coming out? is it planned or a surprise (I know it's
>> planned)
>>
>> What are your hard / soft deadlines?
>>
>> Thanks,
>> Matthew
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
