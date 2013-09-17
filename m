From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Tests: Add UST snapshots
 list output and max-size tests
Date: Tue, 17 Sep 2013 14:09:20 -0400
Message-ID: <52389AD0.7090003__44368.1041746915$1379442330$gmane$org@efficios.com>
References: <1378764579-11692-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0523758750=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VLziO-000453-PB
	for lttng-dev@lists.lttng.org; Tue, 17 Sep 2013 14:09:39 -0400
In-Reply-To: <1378764579-11692-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0523758750==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigD00DB3734C6D3D65B599DF6F"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD00DB3734C6D3D65B599DF6F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged! (both patches).

David

Christian Babeux:
> Add two new tests to the UST snapshots tests:
>=20
> test_ust_list_output:
> Add/remove named outputs and validate with the list output command.
>=20
> test_ust_local_snapshot_max_size:
> Take a UST snapshot with max-size limits and validate that they are res=
pected.
>=20
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/regression/tools/snapshots/test_ust | 140 ++++++++++++++++++++++=
++++++--
>  1 file changed, 134 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/regression/tools/snapshots/test_ust b/tests/regressi=
on/tools/snapshots/test_ust
> index c88e98a..bd2521c 100755
> --- a/tests/regression/tools/snapshots/test_ust
> +++ b/tests/regression/tools/snapshots/test_ust
> @@ -30,7 +30,7 @@ NR_USEC_WAIT=3D100
> =20
>  TRACE_PATH=3D$(mktemp -d)
> =20
> -NUM_TESTS=3D2053
> +NUM_TESTS=3D2075
> =20
>  source $TESTDIR/utils/utils.sh
> =20
> @@ -38,6 +38,83 @@ if [ ! -x "$TESTAPP_BIN" ]; then
>  	BAIL_OUT "No UST events binary detected."
>  fi
> =20
> +function snapshot_add_output ()
> +{
> +	local sess_name=3D$1
> +	local trace_path=3D$2
> +	local name=3D$3
> +	local max_size=3D$4
> +	local extra_opt=3D""
> +
> +	if [ ! -z $name ]; then
> +		extra_opt+=3D" -n $name "
> +	fi
> +
> +	if [ ! -z $max_size ]; then
> +		extra_opt+=3D" -m $max_size "
> +	fi
> +
> +	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot add-output \
> +		-s $sess_name $extra_opt $trace_path > /dev/null 2>&1
> +
> +	ok $? "Added snapshot output $trace_path ($extra_opt)"
> +}
> +
> +function snapshot_del_output ()
> +{
> +	local sess_name=3D$1
> +	local name=3D$2
> +
> +	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot del-output \
> +		-s $sess_name $name > /dev/null 2>&1
> +
> +	ok $? "Deleted snapshot output named $name"
> +}
> +
> +function enable_mmap_overwrite_subbuf_ust_channel ()
> +{
> +	local sess_name=3D$1
> +	local chan_name=3D$2
> +	local subbuf_size=3D$3
> +
> +	$TESTDIR/../src/bin/lttng/$LTTNG_BIN enable-channel -s $sess_name \
> +		$chan_name -u --output mmap --overwrite \
> +		--subbuf-size $subbuf_size > /dev/null 2>&1
> +
> +	ok $? "Enable channel $channel_name for session $sess_name with subbu=
f size $subbuf_size"
> +}
> +
> +
> +function test_ust_list_output ()
> +{
> +	output_names=3D("randomname" "somesnapshot")
> +
> +	diag "Test UST snapshot output listing"
> +	create_lttng_session_no_output $SESSION_NAME
> +	enable_lttng_mmap_overwrite_ust_channel $SESSION_NAME $CHANNEL_NAME
> +	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
> +
> +	start_lttng_tracing $SESSION_NAME
> +
> +	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" ${output_names=
[0]}
> +
> +	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output \
> +		-s $SESSION_NAME 2>&1 | grep ${output_names[0]} > /dev/null
> +	ok $? "Snapshot named ${output_names[0]} present in list-output listi=
ng"
> +
> +	snapshot_del_output $SESSION_NAME ${output_names[0]}
> +
> +	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" ${output_names=
[1]}
> +
> +	$TESTDIR/../src/bin/lttng/$LTTNG_BIN snapshot list-output \
> +		-s $SESSION_NAME 2>&1 | grep ${output_names[1]} > /dev/null
> +
> +	ok $? "Snapshot named ${output_names[1]} present in list-output listi=
ng"
> +
> +	stop_lttng_tracing $SESSION_NAME
> +	destroy_lttng_session $SESSION_NAME
> +}
> +
>  function test_ust_local_snapshot ()
>  {
>  	diag "Test local UST snapshots"
> @@ -65,6 +142,56 @@ function test_ust_local_snapshot ()
>  	kill $PID_APP >/dev/null 2>&1
>  }
> =20
> +function test_ust_local_snapshot_max_size ()
> +{
> +	subbuf_size=3D8192
> +	num_cpus=3D`nproc`
> +
> +	# The minimum size limit is min(subbuf_size) * nb_streams
> +	max_size=3D$(($subbuf_size*$num_cpus))
> +
> +	diag "Test local UST snapshots with max size $max_size"
> +	create_lttng_session_no_output $SESSION_NAME
> +
> +	enable_mmap_overwrite_subbuf_ust_channel $SESSION_NAME $CHANNEL_NAME =
$subbuf_size
> +
> +	enable_ust_lttng_event $SESSION_NAME $EVENT_NAME $CHANNEL_NAME
> +	start_lttng_tracing $SESSION_NAME
> +
> +	snapshot_add_output $SESSION_NAME "file://$TRACE_PATH" "" $max_size
> +
> +	$TESTAPP_BIN $NR_ITER $NR_USEC_WAIT &
> +	ok $? "Start application to trace"
> +
> +	lttng_snapshot_record $SESSION_NAME
> +
> +	# Check file size
> +	sum_size_tracefiles=3D$(find $TRACE_PATH -name "${CHANNEL_NAME}_*" \
> +		-exec stat -c '%s' {} \; | awk '{s =3D s + $1}END{print s}')
> +
> +	if [ "$sum_size_tracefiles" -gt "$max_size" ]; then
> +		fail "Tracefiles size sum validation"
> +		diag "Tracefiles size sum: $sum_size_tracefiles Expected max: $max_s=
ize"
> +	fi
> +
> +	pass "Tracefiles size sum validation"
> +
> +	stop_lttng_tracing $SESSION_NAME
> +	destroy_lttng_session $SESSION_NAME
> +
> +	# Validate test
> +	validate_trace $EVENT_NAME $TRACE_PATH/
> +
> +	if [ $? -eq 0 ]; then
> +		# Only delete if successful
> +		rm -rf $TRACE_PATH
> +	fi
> +
> +	diag "Killing $TESTAPP_NAME"
> +	PID_APP=3D`pidof $TESTAPP_NAME`
> +	kill $PID_APP >/dev/null 2>&1
> +}
> +
>  function test_ust_local_snapshot_large_metadata ()
>  {
>  	LM_EVENT=3D"tp:tptest1,tp:tptest2,tp:tptest3,tp:tptest4,tp:tptest5"
> @@ -200,17 +327,18 @@ fi
> =20
>  start_lttng_sessiond
> =20
> -tests=3D( test_ust_local_snapshot \
> -	test_ust_per_uid_local_snapshot \
> -	test_ust_per_uid_local_snapshot_post_mortem \
> -	test_ust_local_snapshot_large_metadata \
> +tests=3D( test_ust_list_output
> +	test_ust_local_snapshot
> +	test_ust_local_snapshot_max_size
> +	test_ust_per_uid_local_snapshot
> +	test_ust_per_uid_local_snapshot_post_mortem
> +	test_ust_local_snapshot_large_metadata
>  	test_ust_1000_local_snapshots )
> =20
>  for fct_test in ${tests[@]};
>  do
>  	SESSION_NAME=3D$(randstring 16 0)
>  	${fct_test}
> -
>  done
> =20
>  stop_lttng_sessiond


--------------enigD00DB3734C6D3D65B599DF6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQF8BAEBCgBmBQJSOJrTXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02QsIH/08w0s/RJg/xJqbOHEfM6cSb
LBiJNK9/Q1AAKnvxfbJt8y82BaAnYeeJgM65F1l+veNEg4RhRga8+7GKCLdRwGbs
uBeOmobTQenSPWI0pH+zaAI1CqIry8zRn9YFZHzsD5EJBVdv6zs5iKSouRVyiuti
fAO8OPKWJgDBqVnpSlBILWf9916SaJXgavvu2Xpni7W/6hQyJwSkKSanjd6S1rWR
szBKAuhB6RqN7HlWYBytRVs3qKu+WdHfRSu2dpDoz4EmKrMNi++ggA9cMcDCbXqB
Mkg1jxpejy4MeYAbWmB3Jk9WKBbPqoWq9MeFOJQ1aLKxtzYncWqd6VsqTDnJDMw=
=5Rkq
-----END PGP SIGNATURE-----

--------------enigD00DB3734C6D3D65B599DF6F--


--===============0523758750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0523758750==--
