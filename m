From: Vomlehn <vomlehnd@amazon.com>
Subject: Re: [PATCH lttv] Add build instructions for git tree
 pulls and use more standard formatting
Date: Mon, 19 Aug 2013 12:20:59 -0700
Message-ID: <20130819192059.GA8770__47465.8704399646$1376940154$gmane$org@ub8ca3a8c12a551e580d6.ant.amazon.com>
References: <20130807194853.GA11032@ub8ca3a8c12a551e580d6.ant.amazon.com>
	<5203EC44.7070402@voxpopuli.im>
	<OF8E71E2C5.84B3C9C6-ONC2257BCC.0024AB99-C2257BCC.0024CCB4@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=93604f4b1=vomlehnd@amazon.com>)
	id 1VBV1D-00010G-7L
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 15:21:41 -0400
Content-Disposition: inline
In-Reply-To: <OF8E71E2C5.84B3C9C6-ONC2257BCC.0024AB99-C2257BCC.0024CCB4@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org, Vomlehn <vomlehnd@amazon.com>
List-Id: lttng-dev@lists.lttng.org

Yes, I think you are right. Patch in following message.

On Mon, Aug 19, 2013 at 09:42:25AM +0300, Amit Margalit wrote:
> I thouhght that's what the 'bootstrap' script is for. I mean - it includes 
> autoreconf -i plus creation of config directory... So maybe the doc should 
> say "use the bootstrap script" instead of calling users to run autoreconf 
> -i ...
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> To:     lttng-dev@lists.lttng.org
> Cc:     Vomlehn <vomlehnd@amazon.com>
> Date:   08/08/2013 10:08 PM
> Subject:        Re: [lttng-dev] [PATCH lttv] Add build instructions for 
> git tree pulls and use more standard formatting
> 
> 
> 
> On 13-08-07 03:48 PM, Vomlehn wrote:
> > If the source is obtained directly from git, the file "configure" must 
> be
> > built with the autoconf tools. In addition, example shell commands are
> > traditionally preceeded with a "$" instead of a "-", so this convention
> > is used.
> > ---
> >  README |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/README b/README
> > index 98849b3..ac28f9e 100644
> > --- a/README
> > +++ b/README
> > @@ -31,9 +31,16 @@ libc6 development librairies
> > 
> >  To compile the source tree from a tarball, simply follow these steps :
> > 
> > -- ./configure
> > -- make
> > -- make install
> > +  $ ./configure
> > +  $ make
> > +  $ make install
> > +
> > +To compile the source tree from a git checkout, use:
> > +
> > +  $ autoreconf
> > +  $ automake --add-missing --gnu
> 
> You should be able to use "autoreconf -i" instead of those two commands.
> It avoids the need to run autoconf, automake etc. manually.
> 
> > +  $ make
> > +  $ make install
> 
> As was mentioned in the other thread, this should be "# make install",
> since with the default configure options, it will install in /usr/local,
> and only root can write there.
> 
> Cheers,
> Alex
> 
> > 
> >  After running ./configure, you can also go in specific subdirectories 
> and
> >  use make, make install.
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 

-- 
David VL
