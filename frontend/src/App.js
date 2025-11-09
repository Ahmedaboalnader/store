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

    // Check backend health and measure latency
    const start = Date.now();
    fetch(backendUrl, { method: 'GET' })
      .then(res => {
        const latency = Date.now() - start;
        if (res.ok) {
          setBackendStatus({ connected: true, message: 'Backend connected successfully! ✅', url: backendUrl, latency });
        } else {
          setBackendStatus({ connected: false, message: `Backend responded with ${res.status}`, url: backendUrl, latency });
          throw new Error('Backend responded with non-OK status');
        }
        return res.text();
      })
      .then(() => {
        // Fetch products after confirming backend is up
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
        setBackendStatus(prev => ({ ...prev, connected: false, message: 'Backend connection failed! ❌', url: backendUrl }));
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
        <Box sx={{ mb: 2, display: 'flex', justifyContent: 'center' }}>
          <Alert severity={backendStatus.connected ? 'success' : 'error'} sx={{ width: '100%', maxWidth: 900 }}>
            <strong>{backendStatus.connected ? 'Connected' : 'Disconnected'}</strong>
            {backendStatus.url ? ` — ${backendStatus.url}` : ''}
            {backendStatus.latency ? ` (latency: ${backendStatus.latency}ms)` : ''}
            <div style={{ marginTop: 6 }}>{backendStatus.message}</div>
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
                <Card className="product-card">
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
        <Box sx={{ mt: 6, textAlign: 'center', color: 'text.secondary' }}>
          <Typography variant="body2">© {new Date().getFullYear()} Online Store — demo connection between frontend and backend.</Typography>
        </Box>
      </Container>
    </>
  );
}

export default App;