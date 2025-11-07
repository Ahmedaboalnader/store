import { useEffect, useState } from 'react';
import { 
  AppBar, Toolbar, Typography, Container, Grid, Card, CardContent, 
  CardActions, Button, CircularProgress, Alert, Box, CssBaseline 
} from '@mui/material';

function App() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [backendStatus, setBackendStatus] = useState({ connected: false, message: '' });

  useEffect(() => {
    const backendUrl = process.env.REACT_APP_API_URL || 'http://localhost:5000';

    // Check backend health
    fetch(backendUrl)
      .then(res => {
        if (res.ok) {
          setBackendStatus({ connected: true, message: 'Backend connected successfully! ✅' });
          return res.text();
        }
        throw new Error('Backend not responding');
      })
      .then(() => {
        // Fetch products
        fetch(`${backendUrl}/products`)
          .then(res => res.json())
          .then(data => {
            setProducts(data);
            setLoading(false);
          })
          .catch(err => {
            console.error('❌ Error fetching products:', err);
            setError('Failed to fetch products.');
            setLoading(false);
          });
      })
      .catch(err => {
        console.error('❌ Backend connection error:', err);
        setBackendStatus({ connected: false, message: 'Backend connection failed! ❌' });
        setError('Could not connect to the backend.');
        setLoading(false);
      });
  }, []);

  const addProduct = () => {
    const newProduct = {
      id: products.length + 1,
      name: 'New Product',
      price: Math.floor(Math.random() * 10000),
      description: 'A newly added product'
    };
    setProducts([...products, newProduct]);
  };

  const removeProduct = (id) => {
    setProducts(products.filter(p => p.id !== id));
  };

  return (
    <>
      <CssBaseline />
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Online Store
          </Typography>
        </Toolbar>
      </AppBar>
      <Container sx={{ py: 4 }}>
        <Box sx={{ mb: 2 }}>
          <Alert severity={backendStatus.connected ? 'success' : 'error'}>
            {backendStatus.message || (backendStatus.connected ? 'Backend connected! ✅' : 'Backend connection failed! ❌')}
          </Alert>
        </Box>
        <Box sx={{ display: 'flex', justifyContent: 'center', mb: 4 }}>
          <Button variant="contained" color="primary" onClick={addProduct}>
            Add New Product
          </Button>
        </Box>
        {loading ? (
          <Box sx={{ display: 'flex', justifyContent: 'center' }}>
            <CircularProgress />
          </Box>
        ) : error ? (
          <Alert severity="error">{error}</Alert>
        ) : (
          <Grid container spacing={4}>
            {products.map((product) => (
              <Grid item key={product.id} xs={12} sm={6} md={4}>
                <Card>
                  <CardContent>
                    <Typography gutterBottom variant="h5" component="h2">
                      {product.name}
                    </Typography>
                    <Typography>
                      {product.description || 'No description available.'}
                    </Typography>
                    <Typography variant="h6" color="text.secondary" sx={{ mt: 2 }}>
                      {product.price} EGP
                    </Typography>
                  </CardContent>
                  <CardActions>
                    <Button size="small" color="secondary" onClick={() => removeProduct(product.id)}>
                      Remove
                    </Button>
                    <Button size="small" color="primary">
                      Buy
                    </Button>
                  </CardActions>
                </Card>
              </Grid>
            ))}
          </Grid>
        )}
      </Container>
    </>
  );
}

export default App;