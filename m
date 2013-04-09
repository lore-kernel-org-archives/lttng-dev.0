From: David Goulet <dgoulet@efficios.com>
Subject: Re: Bugfix: Bug #488
Date: Tue, 09 Apr 2013 12:08:04 -0400
Message-ID: <51643CE4.4050902__13597.4292447374$1365523717$gmane$org@efficios.com>
References: <CA+mmcvU4d5ugJmxs4DyPbiis-JS3rMAZ7x8qZswoEDxDKiCssQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UPb5d-0002Di-BH
	for lttng-dev@lists.lttng.org; Tue, 09 Apr 2013 12:08:09 -0400
In-Reply-To: <CA+mmcvU4d5ugJmxs4DyPbiis-JS3rMAZ7x8qZswoEDxDKiCssQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simarpreet Singh <simarpreet007@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Simarpreet,

Can you please rebase your branch on the HEAD of the master branch of
lttng-tools before sending a pull request.

Also, when you fix a bug in the tracker, use "Fix:" with a meaningful
message, add "Fixes #xxx" at the end and finally your signed-off message
like so:

---

Fix: [...]

[more info if necessary]

Fixes #xxx

Signed-off-by: YOUR_NAME <YOUR_EMAIL>

---

Apart from those aesthetics fix, thanks a lot for the contribution. I'll
wait for your fixes to pull back the commits.

Cheers!
David

Simarpreet Singh:
> Hello again,
> 
> Sorry for the emails guys, I fixed a bunch of other typos in the
> codebase, I think these shall go under Bug #488.
> 
> Bug URL: http://bugs.lttng.org/issues/488
> 
> Fix: https://github.com/simar7/lttng-tools/commit/6a6df32f6fadcb85a275b8ea93306af2d498c263
> 
> I've pushed my changes on my github account, I'll try to figure out the
> correct way to file them in the meantime.
> 
> 
> Thanks,
> Simar
> 
> 
> This body part will be downloaded on demand.
