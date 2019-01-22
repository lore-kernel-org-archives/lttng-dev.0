From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: "Hands-free" tracepoints using LD_PRELOAD
Date: Tue, 22 Jan 2019 14:17:48 -0500
Message-ID: <20190122191748.GB17450__2857.31096971489$1548184687$gmane$org@joraj-alpa>
References: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w@mail.gmail.com>
 <CADcCL0gLBOs1L0sqOsPg3+nyHp0sVFGK2ymk0-pw4QRGO7UhGw@mail.gmail.com>
 <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43kdV62jGpznRp
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 14:17:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAF=ZobwMe56-9nb+o=jYcpJVuhxEsHthLCHrkFt8KhEaK5bODQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Brian Rossa <br@f0cal.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Brian,

On Tue, Jan 22, 2019 at 01:30:23PM -0500, Brian Rossa wrote:
>    4. Boilerplate that does the typical `log(...); auto return_val =
>    dlsym(...); log(...); return return_val;` gets generated.

As proposed by Francis, this is when you need to "generate" a corresponding
tracepoint definition and call the tracepoint() call with the appropriate
arguments.

As Francis demonstrated we do not see any reason for lttng-ust not to work here
given that you compile the libshim object correctly.

>    5. `log(...)` is a thin interface to spdlog
>    <https://github.com/gabime/spdlog> that handles `__attribute__`-based
>    setup and teardown of a logger.
> 
> So at the end of the day, the shim developer provides:
> 
>    - The whitelist of mangled names
>    - Implementations of struct "wrappers" that provide custom ostream
>    operators
>    - A map between type names and wrapper names
> 
> The machinery here seems fairly general-purpose, but I don't presume to be
> an expert. My implementation is somewhat error-prone, and my main hope in
> reaching out to the mailing list was that LTTng already had some of these
> steps better-implemented.

AFAIK, lttng does not have an equivalent.

> Step #2 is particularly problematic due to
> ambiguities in the mangling grammar, and will need support going forward to
> generalize well.

What is the status of this step in your project?

What are the problems that make your implementation "error-pone"?

Would you mind linking us to said project so we can have a look?

I would be interested in seeing at first lttng tracepoint used as Francis
demonstrated and see from there were this project can go.

> 
> I would be happy to contribute some or all of my implementation if it's
> something that the LTTng community would be interested in supporting and
> extending.

We are clearly open for discussion and helping you improve the project. I am not
so sure on supporting and extending it. Others might have a different opinion.


Cheers

--
Jonathan Rajotte-Julien
EfficiOS
