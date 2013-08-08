From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttv] Add build instructions for git tree
 pulls and use more standard formatting
Date: Thu, 08 Aug 2013 15:06:44 -0400
Message-ID: <5203EC44.7070402__16036.5662457936$1375988951$gmane$org@voxpopuli.im>
References: <20130807194853.GA11032@ub8ca3a8c12a551e580d6.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1V7VYT-0008KV-Id
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 15:07:30 -0400
In-Reply-To: <20130807194853.GA11032@ub8ca3a8c12a551e580d6.ant.amazon.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Vomlehn <vomlehnd@amazon.com>
List-Id: lttng-dev@lists.lttng.org

On 13-08-07 03:48 PM, Vomlehn wrote:
> If the source is obtained directly from git, the file "configure" must be
> built with the autoconf tools. In addition, example shell commands are
> traditionally preceeded with a "$" instead of a "-", so this convention
> is used.
> ---
>  README |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 98849b3..ac28f9e 100644
> --- a/README
> +++ b/README
> @@ -31,9 +31,16 @@ libc6 development librairies
>  
>  To compile the source tree from a tarball, simply follow these steps :
>  
> -- ./configure
> -- make
> -- make install
> +  $ ./configure
> +  $ make
> +  $ make install
> +
> +To compile the source tree from a git checkout, use:
> +
> +  $ autoreconf
> +  $ automake --add-missing --gnu

You should be able to use "autoreconf -i" instead of those two commands.
It avoids the need to run autoconf, automake etc. manually.

> +  $ make
> +  $ make install

As was mentioned in the other thread, this should be "# make install",
since with the default configure options, it will install in /usr/local,
and only root can write there.

Cheers,
Alex

>  
>  After running ./configure, you can also go in specific subdirectories and
>  use make, make install.
