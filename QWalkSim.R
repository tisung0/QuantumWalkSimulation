
N = 1024
t = c(0:50)
w = sample( 1:N, 1 )
u = numeric(N)
uDag = numeric(N)
for( i in 1:N ){
  u[i] = 1/sqrt(N)
}

# create identity matrix
I = matrix(0,N,N ) 
for( i in 1:N ){
  I[i,i] = 1
}
U = (2 * (u %*% t(u)) - I) # does matrix mult

# find unit basis for vector u at w
e = numeric(N)
e[w] = 1

E = ( I - (2 * (e %*% t(e))) )

tmp = U %*% E
psi = tmp
p1 = numeric(51)
tmp1 = 0
for( i in t ){
  if( i == 0 ){
    p1[i+1] = ( (t(e) %*% u) ) ^ 2
  }
  else{
    psi = psi %*% tmp
    tmp1 = psi %*% u
    p1[i+1] = ( ( t(e) %*% tmp1 ) ^ 2 )
  }
}

plot(p1, type="l",main="QR walk SEARCH", xlab="Time Step t", ylab="Probability")


### SECOND HALF
# second half simulates quantum walk algorithm for specific values of k
K = c(4,16)
kFour = matrix( 0, 51, 4 )
kSix = matrix( 0 ,51, 16 )
for( k in K ){
  W = sample( 1:N, k )
  E = numeric(N)
  for( w in W ){
    e = numeric(N)
    e[w] = 1
    E = E + ( e %*% t(e) )
  }
  E = I - ( 2 * ( E ) )
  tmp = U %*% E
  psi = tmp
  p = numeric(51)
  tmp1 = 0
  c = 1
  for( w in W ){
    e = numeric(N)
    e[w] = 1
    for( i in t ){
      if( i == 0 ){
        p[i+1] = ( (t(e) %*% u) ) ^ 2
      }
      else{
        psi = psi %*% tmp
        tmp1 = psi %*% u
        p[i+1] = ( ( t(e) %*% tmp1 ) ^ 2 )
      }
    }
    if( k == 4 ){
      kFour[,c] = p
    }
    else if( k == 16 ){
      kSix[,c] = p
    }
    c = c + 1
  }
}
kF = rowSums(kFour)
kS = rowSums(kSix)
plot(kF, type="l",main="QR walk SEARCH for k=4", xlab="Time Step t", ylab="Probability")
plot(kS, type="l",main="QR walk SEARCH for k=16", xlab="Time Step t", ylab="Probability")


