From: David Goulet <dgoulet@efficios.com>
Subject: Re: [Fix:lttng-tools-PATCH] Fix:Change the type of
 enabled in lttng_event to a signed int
Date: Mon, 11 Jun 2012 14:28:03 -0400
Message-ID: <4FD638B3.6040200__40246.4626975872$1339439319$gmane$org@efficios.com>
References: <1339165148-6653-1-git-send-email-danny.serres@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Se9LT-0000rq-Uq
	for lttng-dev@lists.lttng.org; Mon, 11 Jun 2012 14:28:08 -0400
In-Reply-To: <1339165148-6653-1-git-send-email-danny.serres@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <danny.serres@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey,

Merged upstream!

I'm still considering if I "can" put it in the stable-2.0 branch since this
basically change the lttng.h ABI ...

Thanks!
David

On 08/06/12 10:19 AM, Danny Serres wrote:
> Signed-off-by: Danny Serres <danny.serres@efficios.com> --- 
> include/lttng/lttng.h |    2 +- 1 file changed, 1 insertion(+), 1
> deletion(-)
> 
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h index
> 3b1be61..c80e282 100644 --- a/include/lttng/lttng.h +++
> b/include/lttng/lttng.h @@ -214,7 +214,7 @@ struct lttng_event { enum
> lttng_loglevel_type loglevel_type; int loglevel;
> 
> -	uint32_t enabled; +	int32_t enabled;	/* Does not apply: -1 */ pid_t pid;
> 
> char padding[LTTNG_EVENT_PADDING1];
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP1jiwAAoJEELoaioR9I02DmgIAI5JS3wQCwoBOIxKJz4GkA2+
QC7AEtCRKfG6AGPi3MN7EGav+hCTHAxfGK3CWr3CDi/Vo7uE3ofZ6wI3HgTdF1aH
rEZPho96hhvsdu5p33HGg1BHuKhteYKa/TukzURBRPlu0+ruDol0rFsJn/SXblTe
WczjFTRku+EAmF55V+gXOwhZ0wazZ47lcKIIg5EZMuSQo5PsRh/OD+w5j+15+2QP
nHCFzEWEevnKmfmlhSfi0voyvNlxLzmc9ppv0AWUYX5mbppL6aCjHVu+RUphAAL4
R2D+C6ApRQOWnn+pFj3SALxas3sWuDHDCDCXSesjCWYT5wRoM6wY/ykgETC3Q+U=
=sPTt
-----END PGP SIGNATURE-----
