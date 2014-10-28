From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH] lttng-tools: remove bogus argument from
 prove invocation
Date: Mon, 27 Oct 2014 23:02:58 -0500
Message-ID: <544F1572.2040702__36209.5688273714$1414469025$gmane$org@mentor.com>
References: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
 <CAF4oYfEgNmiThfUW9Kj8+pYu-3QdE4KtUivr9mztf-Jb-=rocQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1Xixzt-0002UH-IS
 for lttng-dev@lists.lttng.org; Tue, 28 Oct 2014 00:03:06 -0400
In-Reply-To: <CAF4oYfEgNmiThfUW9Kj8+pYu-3QdE4KtUivr9mztf-Jb-=rocQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 10/27/2014 09:38 PM, Jonathan Rajotte wrote:
> Hey
> 
> On Mon, Oct 27, 2014 at 10:00 PM, Nathan Lynch <nathan_lynch@mentor.com
> <mailto:nathan_lynch@mentor.com>> wrote:
> 
>     An argument of "$2" was added to the prove command line in
>     tests/run.sh by 68270f0f604e "Mi test: Basic test structure".  This is
>     harmless since run.sh is never called with more than one argument, but
> 
> 
> The multiple arguments could be overcome by adding "" to the multiple
> test files list but as you said it is confusing and error prone.  
> 
> This actually can be used to debug test with a "-v". Or add any basic
> arguments to the prove command and was simply convenient at the time.If
> this actually break patch from OE ( I assume OE stand for OpenEmbedded
> and you are talking about this commit [1])  I'm okai with reverting the
> change I introduced.

I didn't intend to imply that upstream LTTng is responsible for keeping
patches working in a downstream project like OE.  I mentioned OE because
that's how my attention was drawn to this change.

If the $2 argument has a legitimate use, I suggest that it be made a bit
more clear since 1) the commit that introduced it didn't mention it at
all, and 2) no code in-tree actually makes use of the extra argument.

I figured it was likely a mistake.
