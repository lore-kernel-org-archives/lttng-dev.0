From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Ping: Re: [PATCH lttng-ust] Bugfix for
	http://bugs.lttng.org/issues/745
Date: Thu, 10 Jul 2014 14:49:37 +0200
Message-ID: <53BE8BE1.1000509__47679.2971756824$1404996658$gmane$org@mentor.com>
References: <1404476512-18305-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X5DnI-0006ma-9G
 for lttng-dev@lists.lttng.org; Thu, 10 Jul 2014 08:49:52 -0400
In-Reply-To: <1404476512-18305-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Since we have no other options currently (see LD_AUDIT discussion) we
really should get this merged into master. As said, it's thoroughly
tested and should not cause any ill side-effects.

Many Thanks,
Paul

On 07/04/2014 02:21 PM, Paul Woegerer wrote:
> Since (at least) in the short term LD_AUDIT will not be able to make sem_wait()
> in the static constructor go away I provide the following patch to fix
> http://bugs.lttng.org/issues/745.
> 
> It works by making the process of forking mutual exclusive with base address
> statedumping that happens from the ust_listener_thread.
> 
> I have tested this fix with several variations of (constrained) fork bombs
> (including tests/regression/ust/daemon from lttng-tools) on x86_64, ARM(imx6q)
> and powerpc(P4080DS). It works reliable. I could not find any issues with this
> approach.
> 
> Paul Woegerer (1):
>   Bugfix for #745 deadlock with baddr statedump+fork
> 
>  liblttng-ust/lttng-ust-comm.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
